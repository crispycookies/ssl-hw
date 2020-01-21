	component HPSPlatform is
		port (
			apd9301_extern_scl                   : inout std_logic                     := 'X';             -- scl
			apd9301_extern_scl_logic             : out   std_logic;                                        -- scl_logic
			apd9301_extern_sda                   : inout std_logic                     := 'X';             -- sda
			apd9301_extern_sda_logic             : out   std_logic;                                        -- sda_logic
			clk_clk                              : in    std_logic                     := 'X';             -- clk
			h2f_reset_reset_n                    : out   std_logic;                                        -- reset_n
			hdc1000_extern_sensor_drdy           : in    std_logic                     := 'X';             -- sensor_drdy
			hdc1000_extern_sensor_drdy_testing   : out   std_logic;                                        -- sensor_drdy_testing
			hdc1000_extern_i2c_scl               : inout std_logic                     := 'X';             -- i2c_scl
			hdc1000_extern_i2c_scl_testing       : out   std_logic;                                        -- i2c_scl_testing
			hdc1000_extern_i2c_sda               : inout std_logic                     := 'X';             -- i2c_sda
			hdc1000_extern_i2c_sda_testing       : out   std_logic;                                        -- i2c_sda_testing
			hps_0_f2h_cold_reset_req_reset_n     : in    std_logic                     := 'X';             -- reset_n
			hps_0_f2h_debug_reset_req_reset_n    : in    std_logic                     := 'X';             -- reset_n
			hps_0_f2h_stm_hw_events_stm_hwevents : in    std_logic_vector(27 downto 0) := (others => 'X'); -- stm_hwevents
			hps_0_f2h_warm_reset_req_reset_n     : in    std_logic                     := 'X';             -- reset_n
			hps_io_hps_io_emac1_inst_TX_CLK      : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
			hps_io_hps_io_emac1_inst_TXD0        : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
			hps_io_hps_io_emac1_inst_TXD1        : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
			hps_io_hps_io_emac1_inst_TXD2        : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
			hps_io_hps_io_emac1_inst_TXD3        : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
			hps_io_hps_io_emac1_inst_RXD0        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
			hps_io_hps_io_emac1_inst_MDIO        : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
			hps_io_hps_io_emac1_inst_MDC         : out   std_logic;                                        -- hps_io_emac1_inst_MDC
			hps_io_hps_io_emac1_inst_RX_CTL      : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
			hps_io_hps_io_emac1_inst_TX_CTL      : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
			hps_io_hps_io_emac1_inst_RX_CLK      : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
			hps_io_hps_io_emac1_inst_RXD1        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
			hps_io_hps_io_emac1_inst_RXD2        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
			hps_io_hps_io_emac1_inst_RXD3        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
			hps_io_hps_io_sdio_inst_CMD          : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
			hps_io_hps_io_sdio_inst_D0           : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
			hps_io_hps_io_sdio_inst_D1           : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
			hps_io_hps_io_sdio_inst_CLK          : out   std_logic;                                        -- hps_io_sdio_inst_CLK
			hps_io_hps_io_sdio_inst_D2           : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
			hps_io_hps_io_sdio_inst_D3           : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
			hps_io_hps_io_usb1_inst_D0           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
			hps_io_hps_io_usb1_inst_D1           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
			hps_io_hps_io_usb1_inst_D2           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
			hps_io_hps_io_usb1_inst_D3           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
			hps_io_hps_io_usb1_inst_D4           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
			hps_io_hps_io_usb1_inst_D5           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
			hps_io_hps_io_usb1_inst_D6           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
			hps_io_hps_io_usb1_inst_D7           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
			hps_io_hps_io_usb1_inst_CLK          : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
			hps_io_hps_io_usb1_inst_STP          : out   std_logic;                                        -- hps_io_usb1_inst_STP
			hps_io_hps_io_usb1_inst_DIR          : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
			hps_io_hps_io_usb1_inst_NXT          : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
			hps_io_hps_io_spim1_inst_CLK         : out   std_logic;                                        -- hps_io_spim1_inst_CLK
			hps_io_hps_io_spim1_inst_MOSI        : out   std_logic;                                        -- hps_io_spim1_inst_MOSI
			hps_io_hps_io_spim1_inst_MISO        : in    std_logic                     := 'X';             -- hps_io_spim1_inst_MISO
			hps_io_hps_io_spim1_inst_SS0         : out   std_logic;                                        -- hps_io_spim1_inst_SS0
			hps_io_hps_io_uart0_inst_RX          : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
			hps_io_hps_io_uart0_inst_TX          : out   std_logic;                                        -- hps_io_uart0_inst_TX
			hps_io_hps_io_i2c0_inst_SDA          : inout std_logic                     := 'X';             -- hps_io_i2c0_inst_SDA
			hps_io_hps_io_i2c0_inst_SCL          : inout std_logic                     := 'X';             -- hps_io_i2c0_inst_SCL
			hps_io_hps_io_i2c1_inst_SDA          : inout std_logic                     := 'X';             -- hps_io_i2c1_inst_SDA
			hps_io_hps_io_i2c1_inst_SCL          : inout std_logic                     := 'X';             -- hps_io_i2c1_inst_SCL
			hps_io_hps_io_gpio_inst_GPIO09       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO09
			hps_io_hps_io_gpio_inst_GPIO35       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO35
			hps_io_hps_io_gpio_inst_GPIO40       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO40
			hps_io_hps_io_gpio_inst_GPIO48       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO48
			hps_io_hps_io_gpio_inst_GPIO53       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO53
			hps_io_hps_io_gpio_inst_GPIO54       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO54
			hps_io_hps_io_gpio_inst_GPIO61       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO61
			leds_external_connection_export      : out   std_logic_vector(9 downto 0);                     -- export
			memory_mem_a                         : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba                        : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                        : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n                      : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke                       : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n                      : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n                     : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n                     : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n                      : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n                   : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                        : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs                       : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n                     : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt                       : out   std_logic;                                        -- mem_odt
			memory_mem_dm                        : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin                     : in    std_logic                     := 'X';             -- oct_rzqin
			mpu9250_extern_sdo                   : in    std_logic                     := 'X';             -- sdo
			mpu9250_extern_cs                    : inout std_logic                     := 'X';             -- cs
			mpu9250_extern_fsync                 : out   std_logic;                                        -- fsync
			mpu9250_extern_sclk                  : inout std_logic                     := 'X';             -- sclk
			mpu9250_extern_sdi                   : inout std_logic                     := 'X';             -- sdi
			mpu9250_extern_sclk_dbg              : out   std_logic;                                        -- sclk_dbg
			mpu9250_extern_sdi_dbg               : out   std_logic;                                        -- sdi_dbg
			mpu9250_extern_sdo_dbg               : out   std_logic;                                        -- sdo_dbg
			mpu9250_extern_cs_dbg                : out   std_logic;                                        -- cs_dbg
			reset_reset_n                        : in    std_logic                     := 'X';             -- reset_n
			seven_segment_conduit_end_export     : out   std_logic_vector(41 downto 0);                    -- export
			switches_external_connection_export  : in    std_logic_vector(9 downto 0)  := (others => 'X')  -- export
		);
	end component HPSPlatform;

	u0 : component HPSPlatform
		port map (
			apd9301_extern_scl                   => CONNECTED_TO_apd9301_extern_scl,                   --               apd9301_extern.scl
			apd9301_extern_scl_logic             => CONNECTED_TO_apd9301_extern_scl_logic,             --                             .scl_logic
			apd9301_extern_sda                   => CONNECTED_TO_apd9301_extern_sda,                   --                             .sda
			apd9301_extern_sda_logic             => CONNECTED_TO_apd9301_extern_sda_logic,             --                             .sda_logic
			clk_clk                              => CONNECTED_TO_clk_clk,                              --                          clk.clk
			h2f_reset_reset_n                    => CONNECTED_TO_h2f_reset_reset_n,                    --                    h2f_reset.reset_n
			hdc1000_extern_sensor_drdy           => CONNECTED_TO_hdc1000_extern_sensor_drdy,           --               hdc1000_extern.sensor_drdy
			hdc1000_extern_sensor_drdy_testing   => CONNECTED_TO_hdc1000_extern_sensor_drdy_testing,   --                             .sensor_drdy_testing
			hdc1000_extern_i2c_scl               => CONNECTED_TO_hdc1000_extern_i2c_scl,               --                             .i2c_scl
			hdc1000_extern_i2c_scl_testing       => CONNECTED_TO_hdc1000_extern_i2c_scl_testing,       --                             .i2c_scl_testing
			hdc1000_extern_i2c_sda               => CONNECTED_TO_hdc1000_extern_i2c_sda,               --                             .i2c_sda
			hdc1000_extern_i2c_sda_testing       => CONNECTED_TO_hdc1000_extern_i2c_sda_testing,       --                             .i2c_sda_testing
			hps_0_f2h_cold_reset_req_reset_n     => CONNECTED_TO_hps_0_f2h_cold_reset_req_reset_n,     --     hps_0_f2h_cold_reset_req.reset_n
			hps_0_f2h_debug_reset_req_reset_n    => CONNECTED_TO_hps_0_f2h_debug_reset_req_reset_n,    --    hps_0_f2h_debug_reset_req.reset_n
			hps_0_f2h_stm_hw_events_stm_hwevents => CONNECTED_TO_hps_0_f2h_stm_hw_events_stm_hwevents, --      hps_0_f2h_stm_hw_events.stm_hwevents
			hps_0_f2h_warm_reset_req_reset_n     => CONNECTED_TO_hps_0_f2h_warm_reset_req_reset_n,     --     hps_0_f2h_warm_reset_req.reset_n
			hps_io_hps_io_emac1_inst_TX_CLK      => CONNECTED_TO_hps_io_hps_io_emac1_inst_TX_CLK,      --                       hps_io.hps_io_emac1_inst_TX_CLK
			hps_io_hps_io_emac1_inst_TXD0        => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD0,        --                             .hps_io_emac1_inst_TXD0
			hps_io_hps_io_emac1_inst_TXD1        => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD1,        --                             .hps_io_emac1_inst_TXD1
			hps_io_hps_io_emac1_inst_TXD2        => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD2,        --                             .hps_io_emac1_inst_TXD2
			hps_io_hps_io_emac1_inst_TXD3        => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD3,        --                             .hps_io_emac1_inst_TXD3
			hps_io_hps_io_emac1_inst_RXD0        => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD0,        --                             .hps_io_emac1_inst_RXD0
			hps_io_hps_io_emac1_inst_MDIO        => CONNECTED_TO_hps_io_hps_io_emac1_inst_MDIO,        --                             .hps_io_emac1_inst_MDIO
			hps_io_hps_io_emac1_inst_MDC         => CONNECTED_TO_hps_io_hps_io_emac1_inst_MDC,         --                             .hps_io_emac1_inst_MDC
			hps_io_hps_io_emac1_inst_RX_CTL      => CONNECTED_TO_hps_io_hps_io_emac1_inst_RX_CTL,      --                             .hps_io_emac1_inst_RX_CTL
			hps_io_hps_io_emac1_inst_TX_CTL      => CONNECTED_TO_hps_io_hps_io_emac1_inst_TX_CTL,      --                             .hps_io_emac1_inst_TX_CTL
			hps_io_hps_io_emac1_inst_RX_CLK      => CONNECTED_TO_hps_io_hps_io_emac1_inst_RX_CLK,      --                             .hps_io_emac1_inst_RX_CLK
			hps_io_hps_io_emac1_inst_RXD1        => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD1,        --                             .hps_io_emac1_inst_RXD1
			hps_io_hps_io_emac1_inst_RXD2        => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD2,        --                             .hps_io_emac1_inst_RXD2
			hps_io_hps_io_emac1_inst_RXD3        => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD3,        --                             .hps_io_emac1_inst_RXD3
			hps_io_hps_io_sdio_inst_CMD          => CONNECTED_TO_hps_io_hps_io_sdio_inst_CMD,          --                             .hps_io_sdio_inst_CMD
			hps_io_hps_io_sdio_inst_D0           => CONNECTED_TO_hps_io_hps_io_sdio_inst_D0,           --                             .hps_io_sdio_inst_D0
			hps_io_hps_io_sdio_inst_D1           => CONNECTED_TO_hps_io_hps_io_sdio_inst_D1,           --                             .hps_io_sdio_inst_D1
			hps_io_hps_io_sdio_inst_CLK          => CONNECTED_TO_hps_io_hps_io_sdio_inst_CLK,          --                             .hps_io_sdio_inst_CLK
			hps_io_hps_io_sdio_inst_D2           => CONNECTED_TO_hps_io_hps_io_sdio_inst_D2,           --                             .hps_io_sdio_inst_D2
			hps_io_hps_io_sdio_inst_D3           => CONNECTED_TO_hps_io_hps_io_sdio_inst_D3,           --                             .hps_io_sdio_inst_D3
			hps_io_hps_io_usb1_inst_D0           => CONNECTED_TO_hps_io_hps_io_usb1_inst_D0,           --                             .hps_io_usb1_inst_D0
			hps_io_hps_io_usb1_inst_D1           => CONNECTED_TO_hps_io_hps_io_usb1_inst_D1,           --                             .hps_io_usb1_inst_D1
			hps_io_hps_io_usb1_inst_D2           => CONNECTED_TO_hps_io_hps_io_usb1_inst_D2,           --                             .hps_io_usb1_inst_D2
			hps_io_hps_io_usb1_inst_D3           => CONNECTED_TO_hps_io_hps_io_usb1_inst_D3,           --                             .hps_io_usb1_inst_D3
			hps_io_hps_io_usb1_inst_D4           => CONNECTED_TO_hps_io_hps_io_usb1_inst_D4,           --                             .hps_io_usb1_inst_D4
			hps_io_hps_io_usb1_inst_D5           => CONNECTED_TO_hps_io_hps_io_usb1_inst_D5,           --                             .hps_io_usb1_inst_D5
			hps_io_hps_io_usb1_inst_D6           => CONNECTED_TO_hps_io_hps_io_usb1_inst_D6,           --                             .hps_io_usb1_inst_D6
			hps_io_hps_io_usb1_inst_D7           => CONNECTED_TO_hps_io_hps_io_usb1_inst_D7,           --                             .hps_io_usb1_inst_D7
			hps_io_hps_io_usb1_inst_CLK          => CONNECTED_TO_hps_io_hps_io_usb1_inst_CLK,          --                             .hps_io_usb1_inst_CLK
			hps_io_hps_io_usb1_inst_STP          => CONNECTED_TO_hps_io_hps_io_usb1_inst_STP,          --                             .hps_io_usb1_inst_STP
			hps_io_hps_io_usb1_inst_DIR          => CONNECTED_TO_hps_io_hps_io_usb1_inst_DIR,          --                             .hps_io_usb1_inst_DIR
			hps_io_hps_io_usb1_inst_NXT          => CONNECTED_TO_hps_io_hps_io_usb1_inst_NXT,          --                             .hps_io_usb1_inst_NXT
			hps_io_hps_io_spim1_inst_CLK         => CONNECTED_TO_hps_io_hps_io_spim1_inst_CLK,         --                             .hps_io_spim1_inst_CLK
			hps_io_hps_io_spim1_inst_MOSI        => CONNECTED_TO_hps_io_hps_io_spim1_inst_MOSI,        --                             .hps_io_spim1_inst_MOSI
			hps_io_hps_io_spim1_inst_MISO        => CONNECTED_TO_hps_io_hps_io_spim1_inst_MISO,        --                             .hps_io_spim1_inst_MISO
			hps_io_hps_io_spim1_inst_SS0         => CONNECTED_TO_hps_io_hps_io_spim1_inst_SS0,         --                             .hps_io_spim1_inst_SS0
			hps_io_hps_io_uart0_inst_RX          => CONNECTED_TO_hps_io_hps_io_uart0_inst_RX,          --                             .hps_io_uart0_inst_RX
			hps_io_hps_io_uart0_inst_TX          => CONNECTED_TO_hps_io_hps_io_uart0_inst_TX,          --                             .hps_io_uart0_inst_TX
			hps_io_hps_io_i2c0_inst_SDA          => CONNECTED_TO_hps_io_hps_io_i2c0_inst_SDA,          --                             .hps_io_i2c0_inst_SDA
			hps_io_hps_io_i2c0_inst_SCL          => CONNECTED_TO_hps_io_hps_io_i2c0_inst_SCL,          --                             .hps_io_i2c0_inst_SCL
			hps_io_hps_io_i2c1_inst_SDA          => CONNECTED_TO_hps_io_hps_io_i2c1_inst_SDA,          --                             .hps_io_i2c1_inst_SDA
			hps_io_hps_io_i2c1_inst_SCL          => CONNECTED_TO_hps_io_hps_io_i2c1_inst_SCL,          --                             .hps_io_i2c1_inst_SCL
			hps_io_hps_io_gpio_inst_GPIO09       => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO09,       --                             .hps_io_gpio_inst_GPIO09
			hps_io_hps_io_gpio_inst_GPIO35       => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO35,       --                             .hps_io_gpio_inst_GPIO35
			hps_io_hps_io_gpio_inst_GPIO40       => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO40,       --                             .hps_io_gpio_inst_GPIO40
			hps_io_hps_io_gpio_inst_GPIO48       => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO48,       --                             .hps_io_gpio_inst_GPIO48
			hps_io_hps_io_gpio_inst_GPIO53       => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO53,       --                             .hps_io_gpio_inst_GPIO53
			hps_io_hps_io_gpio_inst_GPIO54       => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO54,       --                             .hps_io_gpio_inst_GPIO54
			hps_io_hps_io_gpio_inst_GPIO61       => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO61,       --                             .hps_io_gpio_inst_GPIO61
			leds_external_connection_export      => CONNECTED_TO_leds_external_connection_export,      --     leds_external_connection.export
			memory_mem_a                         => CONNECTED_TO_memory_mem_a,                         --                       memory.mem_a
			memory_mem_ba                        => CONNECTED_TO_memory_mem_ba,                        --                             .mem_ba
			memory_mem_ck                        => CONNECTED_TO_memory_mem_ck,                        --                             .mem_ck
			memory_mem_ck_n                      => CONNECTED_TO_memory_mem_ck_n,                      --                             .mem_ck_n
			memory_mem_cke                       => CONNECTED_TO_memory_mem_cke,                       --                             .mem_cke
			memory_mem_cs_n                      => CONNECTED_TO_memory_mem_cs_n,                      --                             .mem_cs_n
			memory_mem_ras_n                     => CONNECTED_TO_memory_mem_ras_n,                     --                             .mem_ras_n
			memory_mem_cas_n                     => CONNECTED_TO_memory_mem_cas_n,                     --                             .mem_cas_n
			memory_mem_we_n                      => CONNECTED_TO_memory_mem_we_n,                      --                             .mem_we_n
			memory_mem_reset_n                   => CONNECTED_TO_memory_mem_reset_n,                   --                             .mem_reset_n
			memory_mem_dq                        => CONNECTED_TO_memory_mem_dq,                        --                             .mem_dq
			memory_mem_dqs                       => CONNECTED_TO_memory_mem_dqs,                       --                             .mem_dqs
			memory_mem_dqs_n                     => CONNECTED_TO_memory_mem_dqs_n,                     --                             .mem_dqs_n
			memory_mem_odt                       => CONNECTED_TO_memory_mem_odt,                       --                             .mem_odt
			memory_mem_dm                        => CONNECTED_TO_memory_mem_dm,                        --                             .mem_dm
			memory_oct_rzqin                     => CONNECTED_TO_memory_oct_rzqin,                     --                             .oct_rzqin
			mpu9250_extern_sdo                   => CONNECTED_TO_mpu9250_extern_sdo,                   --               mpu9250_extern.sdo
			mpu9250_extern_cs                    => CONNECTED_TO_mpu9250_extern_cs,                    --                             .cs
			mpu9250_extern_fsync                 => CONNECTED_TO_mpu9250_extern_fsync,                 --                             .fsync
			mpu9250_extern_sclk                  => CONNECTED_TO_mpu9250_extern_sclk,                  --                             .sclk
			mpu9250_extern_sdi                   => CONNECTED_TO_mpu9250_extern_sdi,                   --                             .sdi
			mpu9250_extern_sclk_dbg              => CONNECTED_TO_mpu9250_extern_sclk_dbg,              --                             .sclk_dbg
			mpu9250_extern_sdi_dbg               => CONNECTED_TO_mpu9250_extern_sdi_dbg,               --                             .sdi_dbg
			mpu9250_extern_sdo_dbg               => CONNECTED_TO_mpu9250_extern_sdo_dbg,               --                             .sdo_dbg
			mpu9250_extern_cs_dbg                => CONNECTED_TO_mpu9250_extern_cs_dbg,                --                             .cs_dbg
			reset_reset_n                        => CONNECTED_TO_reset_reset_n,                        --                        reset.reset_n
			seven_segment_conduit_end_export     => CONNECTED_TO_seven_segment_conduit_end_export,     --    seven_segment_conduit_end.export
			switches_external_connection_export  => CONNECTED_TO_switches_external_connection_export   -- switches_external_connection.export
		);

