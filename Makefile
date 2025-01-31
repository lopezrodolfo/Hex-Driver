upload: hardware.bin firmware.bin
	iceprog hardware.bin
	sleep 1
	iceprog -o 1M firmware.bin

fw: firmware.bin
	iceprog -o 1M firmware.bin

hardware.bin: hardware.asc
	icetime -d up5k -c 12 -mtr timing.rpt hardware.asc
	icepack hardware.asc hardware.bin

hardware.asc: upduino3.pcf hardware.json
	nextpnr-ice40 -ql nextpnr.log --freq 13 --timing-allow-fail --up5k --package sg48 \
	              --asc hardware.asc --pcf upduino3.pcf --json hardware.json

hardware.json: top.v ice40up5k_spram.v spimemio.v simpleuart.v picosoc.v picorv32.v
	yosys -ql yosys.log -p 'synth_ice40 -top top -json hardware.json' $^

firmware.bin: firmware.elf
	riscv64-unknown-elf-objcopy -O binary firmware.elf /dev/stdout > firmware.bin

firmware.elf: firmware_sections.lds start.s firmware.c
	riscv64-unknown-elf-gcc -march=rv32ic -mabi=ilp32 -Wl,\
	-Bstatic,-T,firmware_sections.lds,--strip-debug -ffreestanding \
	-nostdlib -o firmware.elf start.s firmware.c

firmware_sections.lds: sections.lds
	riscv64-unknown-elf-cpp -march=rv32ic -mabi=ilp32 -P -o $@ $^

clean:
	rm -f firmware.elf firmware.hex firmware.bin firmware.o firmware.map \
	      hardware.blif  hardware.asc hardware.bin hardware.json \
		  *.log *.rpt *.elf




