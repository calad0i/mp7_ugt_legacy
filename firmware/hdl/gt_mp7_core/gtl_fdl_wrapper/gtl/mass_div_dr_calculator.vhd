
-- Description:
-- Calculation of invariant mass divided by deltaR based on LUTs (ROMs).

-- Version history:
-- HB 2020-05-14: first design.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.math_pkg.all;

use work.gtl_pkg.all;

entity mass_div_dr_calculator is
    generic (
        rom_sel : natural := CALO_CALO_ROM;
        deta_bins_width : natural := 8;
        dphi_bins_width : natural := 8;
-- limits for comparison of invariant mass divided by deltaR
        mass_upper_limit_vector: std_logic_vector(MAX_WIDTH_MASS_DIV_DR_LIMIT_VECTOR-1 downto 0);
        mass_lower_limit_vector: std_logic_vector(MAX_WIDTH_MASS_DIV_DR_LIMIT_VECTOR-1 downto 0);
        pt1_width: positive := 12;
        pt2_width: positive := 12;
        cosh_cos_width: positive := 28;
        inv_dr_sq_width: positive := 26
    );
    port(
        clk : in std_logic := '0';
        deta_bin : in std_logic_vector(deta_bins_width-1 downto 0) := (others => '0');
        dphi_bin : in std_logic_vector(dphi_bins_width-1 downto 0) := (others => '0');
        pt1 : in std_logic_vector(pt1_width-1 downto 0);
        pt2 : in std_logic_vector(pt2_width-1 downto 0);
        cosh_deta : in std_logic_vector(cosh_cos_width-1 downto 0);
        cos_dphi : in std_logic_vector(cosh_cos_width-1 downto 0);
        mass_comp : out std_logic;
-- simulation output
        sim_mass_div_dr : out std_logic_vector(pt1_width+pt2_width+cosh_cos_width+inv_dr_sq_width-1 downto 0)
    );
end mass_div_dr_calculator;

architecture rtl of mass_div_dr_calculator is

    COMPONENT rom_lut_calo_inv_dr_sq_all
    PORT (
        clk : IN STD_LOGIC;
        deta : in STD_LOGIC_VECTOR(7 DOWNTO 0);
        dphi : in STD_LOGIC_VECTOR(7 DOWNTO 0);
        dout : out STD_LOGIC_VECTOR(25 DOWNTO 0)
    );
    END COMPONENT;
    
    COMPONENT rom_lut_muon_inv_dr_sq_all
    PORT (
        clk : IN STD_LOGIC;
        deta : in STD_LOGIC_VECTOR(7 DOWNTO 0);
        dphi : in STD_LOGIC_VECTOR(7 DOWNTO 0);
        dout : out STD_LOGIC_VECTOR(25 DOWNTO 0)
    );
    END COMPONENT;
    
-- HB 2015-10-21: length of std_logic_vector for invariant mass (invariant_mass_sq_div2) and limits.
    constant mass_vector_width : positive := pt1_width+pt2_width+cosh_cos_width;
    constant mass_div_dr_vector_width : positive := mass_vector_width+inv_dr_sq_width;

    signal invariant_mass_sq_div2 : std_logic_vector(mass_vector_width-1 downto 0) := (others => '0');

-- HB 2020-04-23: calculation of invariant mass divided by deltaR (M**2/2 multiplicated with inverse deltaR squared values)
    signal upper_limit : std_logic_vector(mass_div_dr_vector_width-1 downto 0);
    signal lower_limit : std_logic_vector(mass_div_dr_vector_width-1 downto 0);
    signal mass_div_dr : std_logic_vector(mass_div_dr_vector_width-1 downto 0) := (others => '0');
    constant max_mass_div_dr : std_logic_vector(mass_div_dr_vector_width-1 downto 0) := (others => '1');
    signal inv_dr_sq : std_logic_vector(inv_dr_sq_width-1 downto 0);
    
    attribute use_dsp : string;
    attribute use_dsp of invariant_mass_sq_div2 : signal is "yes";
    attribute use_dsp of mass_div_dr : signal is "yes";

begin

    upper_limit <= mass_upper_limit_vector(mass_div_dr_vector_width-1 downto 0);
    lower_limit <= mass_lower_limit_vector(mass_div_dr_vector_width-1 downto 0);
    
-- calculation of invariant mass with formular M**2/2=pt1*pt2*(cosh(eta1-eta2)-cos(phi1-phi2))
    invariant_mass_sq_div2 <= pt1 * pt2 * (cosh_deta - cos_dphi);
    
-- one clk for ROM
    rom_lut_calo_sel: if rom_sel = CALO_CALO_ROM generate
        rom_lut_i : rom_lut_calo_inv_dr_sq_all
            port map (
                clk => clk,
                deta => deta_bin,
                dphi => dphi_bin,
                dout => inv_dr_sq
            );
    end generate rom_lut_calo_sel;

    rom_lut_muon_sel: if rom_sel = MU_MU_ROM generate
        rom_lut_i : rom_lut_muon_inv_dr_sq_all
            port map (
                clk => clk,
                deta => deta_bin,
                dphi => dphi_bin,
                dout => inv_dr_sq
            );
    end generate rom_lut_muon_sel;

    mass_div_dr <= (invariant_mass_sq_div2 * inv_dr_sq) when (inv_dr_sq > 0) else max_mass_div_dr;
    sim_mass_div_dr <= mass_div_dr;
    
--     mass_comp <= '1' when mass_div_dr >= mass_lower_limit_vector(mass_div_dr_vector_width-1 downto 0) and mass_div_dr <= mass_upper_limit_vector(mass_div_dr_vector_width-1 downto 0) else '0';
    mass_comp <= '1' when mass_div_dr >= lower_limit and mass_div_dr <= upper_limit else '0';
    
end architecture rtl;
