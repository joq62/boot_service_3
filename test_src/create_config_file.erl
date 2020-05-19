%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(create_config_file). 
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include_lib("eunit/include/eunit.hrl").
-include("common_macros.hrl").
%% --------------------------------------------------------------------



-compile(export_all).



%% ====================================================================
%% External functions
%% ====================================================================

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------


% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
start()->
    Info=[{vm_name,"pod_computer_1"},
	  {ip_addr,"joqhome.dynamic-dns.net"},
	  {port,40100},
	  {mode,parallell}
	 ],
    misc_lib:unconsult("computer.config",Info),
    ?assertEqual({ok,Info},file:consult("computer.config")).
   
