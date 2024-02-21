transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/manue/Escritorio/dbrenes_digital_design_lab_2024/laboratorio_1/Problema1 {C:/Users/manue/Escritorio/dbrenes_digital_design_lab_2024/laboratorio_1/Problema1/Bin_BCD.sv}

vlog -sv -work work +incdir+C:/Users/manue/Escritorio/dbrenes_digital_design_lab_2024/laboratorio_1/Problema1 {C:/Users/manue/Escritorio/dbrenes_digital_design_lab_2024/laboratorio_1/Problema1/Bin_BCD.sv}
vlog -sv -work work +incdir+C:/Users/manue/Escritorio/dbrenes_digital_design_lab_2024/laboratorio_1/Problema1 {C:/Users/manue/Escritorio/dbrenes_digital_design_lab_2024/laboratorio_1/Problema1/Bin_BCD_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  Bin_BCD

add wave *
view structure
view signals
run -all
