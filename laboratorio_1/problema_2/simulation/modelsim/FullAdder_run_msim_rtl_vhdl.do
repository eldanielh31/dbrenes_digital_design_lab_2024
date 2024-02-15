transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/MRR79/Desktop/TDD/ejercicio2/FullAdder_1bit.vhd}
vcom -93 -work work {C:/Users/MRR79/Desktop/TDD/ejercicio2/FullAdder_4bit.vhd}

vcom -93 -work work {C:/Users/MRR79/Desktop/TDD/ejercicio2/FullAdder_4bit_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  FullAdder_4bit_tb

add wave *
view structure
view signals
run -all
