## HB 2016-08-17: increase limit for better placement performance (set_param place.sliceLegEffortLimit 4000)
## HB 2016-08-31: removed "limit setting"
## HB 2016-08-31: ../ucf/algo_constraints.xdc not used anymore (see uGT_algo.dep)
## JW 2017-10-06: Added payload area constraints

# JW 2017-10-06: Extended payload region to use space of unused GTHs (Greg's suggestion)
resize_pblock [get_pblocks payload] -add {SLICE_X0Y0:SLICE_X29Y449}
resize_pblock [get_pblocks payload] -add {RAMB18_X0Y0:RAMB18_X1Y179}
resize_pblock [get_pblocks payload] -add {RAMB36_X0Y0:RAMB36_X1Y89}

resize_pblock [get_pblocks payload] -add {SLICE_X192Y0:SLICE_X221Y99}
resize_pblock [get_pblocks payload] -add {RAMB18_X13Y0:RAMB18_X14Y39}
resize_pblock [get_pblocks payload] -add {RAMB36_X13Y0:RAMB36_X14Y19}

# JW 2017-10-06: Extend payload region to unused parts of the ctrl region (Greg's suggestion)
resize_pblock [get_pblocks ctrl] -remove {CLOCKREGION_X0Y9:CLOCKREGION_X1Y9}
resize_pblock [get_pblocks ctrl] -add {SLICE_X74Y450:SLICE_X221Y499}
resize_pblock [get_pblocks ctrl] -add {RAMB18_X4Y180:RAMB18_X14Y199}
resize_pblock [get_pblocks ctrl] -add {RAMB36_X4Y90:RAMB36_X14Y99}

resize_pblock [get_pblocks payload] -add {SLICE_X0Y450:SLICE_X73Y499}
resize_pblock [get_pblocks payload] -add {RAMB18_X0Y180:RAMB18_X3Y199}
resize_pblock [get_pblocks payload] -add {RAMB36_X0Y90:RAMB36_X3Y99}

# HB 2017-10-06: used pblock payload for payload.vhd
add_cells_to_pblock [get_pblock payload] payload

# HB 2016-11-17: set output FFs in IOB for finor_2_mezz_lemo, veto_2_mezz_lemo and finor_preview_2_mezz_lemo
set_property IOB TRUE [get_ports {mezz_p[0]}]
set_property IOB TRUE [get_ports {mezz_p[1]}]
set_property IOB TRUE [get_ports {mezz_p[2]}]
