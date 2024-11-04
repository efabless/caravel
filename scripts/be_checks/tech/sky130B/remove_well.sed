s/[^ ]* \(sky130_fd_pr__.fet\)/\1/
s/[^ ]* \(sky130_fd_pr__special_.fet\)/\1/
s/[^ ]* \(sky130_fd_pr__esd_.fet\)/\1/
s/[^ ]* \(sky130_fd_pr__res_high_po\)/\1/
s/[^ ]* \(sky130_fd_pr__res_xhigh_po\)/\1/
s/[^ ]* \(sky130_fd_pr__res_generic_nd\)/\1/
s/[^ ]* \(sky130_fd_pr__res_generic_pd\)/\1/
s/[^ ]* \(sky130_fd_pr__cap_var\)/\1/
s/[^ ]* \(sky130_fd_bs_flash__special_sonosfet_star\)/\1/
s/[^ ]* \(ppolyf_u_1k_6p0\)/\1/
s/[^ ]* \(ppolyf_u\)/\1/
s/[^ ]* \(.fet_06v0\)/\1/
/^D.* sky130_fd_pr__diode_pd2nw_/d
/^D.* sky130_fd_pr__diode_pw2nd_/d
/^D.* sky130_fd_pr__model__parasitic__diode_ps2dn/d
/^D.* diode_pd2nw_06v0/d
/^D.* diode_nd2ps_06v0/d
/^D.* np_6p0/d
/^D.* pn_6p0/d
/^R.* sky130_fd_pr__res_iso_pw/d
/^X.* sky130_fd_pr__pnp_05v5/d
