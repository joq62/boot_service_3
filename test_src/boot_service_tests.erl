%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(boot_service_tests). 
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include_lib("eunit/include/eunit.hrl").
-include("common_macros.hrl").
%% --------------------------------------------------------------------

%% External exports
-export([start/0]).



%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:tes cases
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------
start()->
    spawn(fun()->eunit:test({timeout,10*60,boot_service}) end).

cases_test()->
    ?debugMsg("Test system setup"),
    setup(),
    %% Start application tests
    ?debugMsg("configs test"),    
    ?assertEqual(ok,configs_test:start()),
    ?debugMsg("start boot_service"),    
    ?assertEqual(ok,start_session()),

    ?debugMsg("tcp_client call test"),    
    ?assertEqual(ok,tcp_client_call()),

    ?debugMsg("dns,log master call test"),    
    ?assertEqual(ok,master_call()),    
    ?debugMsg("Start stop_test_system:start"),
    %% End application tests
  
    cleanup(),
    ok.


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
setup()->
    ok.

start_session()->
    ?assertEqual(ok,application:start(boot_service)),
    Node=node(),
    ?assertEqual({pong,Node,boot_service},boot_service:ping()),   
    ok.



tcp_client_call()->
    IpAddr=lib_boot_service:get_config(ip_addr),
    Port=lib_boot_service:get_config(port),
    ?assertMatch({pong,_,boot_service},
		 tcp_client:call({IpAddr,Port},{boot_service,ping,[]})),
    ok.


master_call()->
    IpAddr=lib_boot_service:get_config(ip_addr),
    Port=lib_boot_service:get_config(port),
     ?assertMatch({pong,_,dns_service},
		 tcp_client:call({IpAddr,Port},{dns_service,ping,[]})),
     ?assertMatch({pong,_,log_service},
		 tcp_client:call({IpAddr,Port},{log_service,ping,[]})),
     ?assertMatch({pong,_,master_service},
		 tcp_client:call({IpAddr,Port},{master_service,ping,[]})),

     ?assertMatch({pong,_,master_service},
		  tcp_client:call({IpAddr,Port},{dns_service,all,[]})),
    ok.
cleanup()->
    ?assertEqual(ok,application:stop(boot_service)),  
    ?assertEqual(ok,application:stop(lib_service)),  
    ?assertEqual(ok,application:stop(master_service)),  
    ?assertEqual(ok,application:stop(log_service)),  
    ?assertEqual(ok,application:stop(dns_service)),  
    init:stop().




