all:
	rm -rf *~ */*~ */*/*~ *_service include;
	rm -rf */*.beam;
	rm -rf *.beam erl_crash.dump */erl_crash.dump */*/erl_crash.dump
doc_gen:
	rm -rf doc/*;
	erlc ../doc_gen.erl;
	erl -s doc_gen start -sname doc
test:
	rm -rf *_service include *.beam ebin/* test_ebin/* src/*~ erl_crash.dump;
#	git clone https://github.com/joq62/include;
#	git clone https://github.com/joq62/boot_service;
#	git clone https://github.com/joq62/lib_service;
	cp  ../lib_service/src/*app ebin;
	erlc -I ../include -o ebin ../lib_service/src/*.erl;
	cp src/*app ebin;
	erlc -I ../include -o ebin src/*.erl;
	erlc -I ../include -o test_ebin test_src/*.erl;
	erl -pa ebin -pa test_ebin -s boot_service_tests start -sname boot_test
