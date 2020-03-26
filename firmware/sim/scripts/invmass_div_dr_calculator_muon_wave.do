onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix ufixed -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/pt1
add wave -noupdate -radix ufixed -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/pt2
add wave -noupdate -radix ufixed -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/diff_eta
add wave -noupdate -radix ufixed -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/diff_phi
add wave -noupdate -radix ufixed -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/cosh_deta
add wave -noupdate -radix ufixed -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/cos_dphi
add wave -noupdate -radix binary -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/cos_dphi
add wave -noupdate /invmass_div_dr_calculator_muon_tb/cos_dphi_sign
add wave -noupdate -radix ufixed /invmass_div_dr_calculator_muon_tb/dut/mass_div_dr_upper_limit
add wave -noupdate -radix ufixed /invmass_div_dr_calculator_muon_tb/dut/mass_div_dr_lower_limit
add wave -noupdate -radix ufixed /invmass_div_dr_calculator_muon_tb/dut/dr_sq
add wave -noupdate -radix ufixed /invmass_div_dr_calculator_muon_tb/dut/invariant_mass_sq_div2_temp
add wave -noupdate -radix binary -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/dut/invariant_mass_sq_div2_temp
add wave -noupdate -radix ufixed -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/dut/invariant_mass_sq_div2
add wave -noupdate -radix binary -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/dut/invariant_mass_sq_div2
add wave -noupdate -radix ufixed /invmass_div_dr_calculator_muon_tb/dut/invmass_sq_div2_div_dr_sq_temp
add wave -noupdate -radix binary -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/dut/invmass_sq_div2_div_dr_sq_temp
add wave -noupdate -radix ufixed -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/dut/invmass_sq_div2_div_dr_sq
add wave -noupdate -radix binary -radixshowbase 0 /invmass_div_dr_calculator_muon_tb/dut/invmass_sq_div2_div_dr_sq
add wave -noupdate /invmass_div_dr_calculator_muon_tb/dut/mass_div_dr_comp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {136349 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 477
configure wave -valuecolwidth 612
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
WaveRestoreZoom {0 ps} {265187 ps}
