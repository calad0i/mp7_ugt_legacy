onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mass_div_dr_calo_tb/lhc_clk
add wave -noupdate -radix decimal /mass_div_dr_calo_tb/calc_cut_mass_over_dr_eg_eg_bx_0_bx_0_i/inv_mass_pt_in_p(0)(1)
add wave -noupdate -radix decimal /mass_div_dr_calo_tb/cond_invariant_mass_delta_r_i0_i/mass_div_dr_threshold
add wave -noupdate -radix decimal /mass_div_dr_calo_tb/eg_eg_bx_0_bx_0_mass_over_dr(0)(1)
add wave -noupdate /mass_div_dr_calo_tb/cond_invariant_mass_delta_r_i0_i/mass_div_dr_comp_pipe(0)(1)
add wave -noupdate /mass_div_dr_calo_tb/cond_invariant_mass_delta_r_i0_i/condition_and_or
add wave -noupdate /mass_div_dr_calo_tb/cond_invariant_mass_delta_r_i0_i/condition_o
add wave -noupdate -divider 1/DR^2
add wave -noupdate -radix decimal /mass_div_dr_calo_tb/calc_cut_mass_over_dr_eg_eg_bx_0_bx_0_i/calo_deta_bin(0)(1)
add wave -noupdate -radix decimal /mass_div_dr_calo_tb/calc_cut_mass_over_dr_eg_eg_bx_0_bx_0_i/calo_dphi_bin(0)(1)
add wave -noupdate -radix decimal /mass_div_dr_calo_tb/calc_cut_mass_over_dr_eg_eg_bx_0_bx_0_i/inverted_dr_sq(0)(1)
add wave -noupdate -divider Details
add wave -noupdate /mass_div_dr_calo_tb/calc_cut_mass_over_dr_eg_eg_bx_0_bx_0_i/cuts_l_1(0)/cuts_l_2(1)/mass_over_dr_sel/rom_lut_calo_sel/rom_lut_i/addr_lsb
add wave -noupdate /mass_div_dr_calo_tb/calc_cut_mass_over_dr_eg_eg_bx_0_bx_0_i/cuts_l_1(0)/cuts_l_2(1)/mass_over_dr_sel/rom_lut_calo_sel/rom_lut_i/addr_msb
add wave -noupdate -radix unsigned /mass_div_dr_calo_tb/calc_cut_mass_over_dr_eg_eg_bx_0_bx_0_i/cuts_l_1(0)/cuts_l_2(1)/mass_over_dr_sel/rom_lut_calo_sel/rom_lut_i/dout1
add wave -noupdate -radix unsigned /mass_div_dr_calo_tb/calc_cut_mass_over_dr_eg_eg_bx_0_bx_0_i/cuts_l_1(0)/cuts_l_2(1)/mass_over_dr_sel/rom_lut_calo_sel/rom_lut_i/dout2
add wave -noupdate -radix unsigned /mass_div_dr_calo_tb/calc_cut_mass_over_dr_eg_eg_bx_0_bx_0_i/cuts_l_1(0)/cuts_l_2(1)/mass_over_dr_sel/rom_lut_calo_sel/rom_lut_i/dout3
add wave -noupdate -radix unsigned /mass_div_dr_calo_tb/calc_cut_mass_over_dr_eg_eg_bx_0_bx_0_i/cuts_l_1(0)/cuts_l_2(1)/mass_over_dr_sel/rom_lut_calo_sel/rom_lut_i/dout4
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {149704 ps} 0} {{Cursor 2} {421895479 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 880
configure wave -valuecolwidth 126
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {80496 ps} {214668 ps}
