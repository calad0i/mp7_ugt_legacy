
-- Description:
-- Dummy module for "anomaly detection trigger (ADT)" test.

-- Version history:
-- HB 2022-01-21: first design.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all; -- for function "CONV_INTEGER"

use work.gtl_pkg.all;

entity adt_2_dummy is
    port(
        lhc_clk: in std_logic;
--         clk240: in std_logic;
        adt_in: in bx_data_record;
        adt_out: out std_logic
    );
end adt_2_dummy;

architecture rtl of adt_2_dummy is

begin

-- for tests used EG bx0 object 2 bit 0 as adt
adt_out <= adt_in.eg(2)(2)(0);

end architecture rtl;