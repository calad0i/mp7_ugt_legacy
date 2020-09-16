entity output_logic is
   generic
   (
      ADDR_WIDTH : integer := 3
   );
   port
   (
      daq_clk : in  std_logic;
      daq_rst : in  std_logic;

      -- software registers
      sw_reg_in : in  sw_reg_rop_in_t;

      -- interface to address fetch unit
      pkt_available : in  std_logic;
      pkt_req       : out std_logic;

      addr_bx_in_event : out std_logic_vector(log2c(MAX_BX_IN_EVENT)-1 downto 0);

      -- tcm interface
      trigger_nr        : in  trigger_nr_t;
      orbit_nr          : in  orbit_nr_t;
      bx_nr             : in  bx_nr_t;
      luminosity_seg_nr : in  luminosity_seg_nr_t;
      event_nr          : in  event_nr_t;

      -- lhc interface
      lhc_data  : in  lhc_data_t;

      -- fdl interface
      algo_before_pre : in  std_logic_vector(MAX_NR_ALGOS-1 downto 0);
      algo_after_pre  : in  std_logic_vector(MAX_NR_ALGOS-1 downto 0);
      algo_after_mask : in  std_logic_vector(MAX_NR_ALGOS-1 downto 0);

      -- finors
      finors : in  std_logic_vector(FINOR_WIDTH-1 downto 0);

      -- daq interface
      daq_data : out std_logic_vector (DAQ_INPUT_WIDTH-1 downto 0);
      daq_oe   : out std_logic;
      daq_stop : out std_logic;
      daq_busy : in  std_logic
   );
end output_logic;