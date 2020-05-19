all:
	rm -rf basic *_service include pod_*;
	git clone https://github.com/joq62/basic.git;
	# boot_service
	cp -r basic/boot_service .;
	cp boot_service/src/*.app boot_service/ebin;
	erlc -D public -I basic/include -o boot_service/ebin boot_service/src/*.erl;
	# lib_service
	cp -r basic/lib_service .;
	cp lib_service/src/*.app lib_service/ebin;
	erlc -D local -I basic/include -o lib_service/ebin lib_service/src/*.erl;
	# start
	erl -pa */ebin -pa ebin -s boot_service start -sname pod_40010
