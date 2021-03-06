	HPSPlatform u0 (
		.apd9301_extern_scl                   (<connected-to-apd9301_extern_scl>),                   //               apd9301_extern.scl
		.apd9301_extern_scl_logic             (<connected-to-apd9301_extern_scl_logic>),             //                             .scl_logic
		.apd9301_extern_sda                   (<connected-to-apd9301_extern_sda>),                   //                             .sda
		.apd9301_extern_sda_logic             (<connected-to-apd9301_extern_sda_logic>),             //                             .sda_logic
		.clk_clk                              (<connected-to-clk_clk>),                              //                          clk.clk
		.h2f_reset_reset_n                    (<connected-to-h2f_reset_reset_n>),                    //                    h2f_reset.reset_n
		.hdc1000_extern_sensor_drdy           (<connected-to-hdc1000_extern_sensor_drdy>),           //               hdc1000_extern.sensor_drdy
		.hdc1000_extern_sensor_drdy_testing   (<connected-to-hdc1000_extern_sensor_drdy_testing>),   //                             .sensor_drdy_testing
		.hdc1000_extern_i2c_scl               (<connected-to-hdc1000_extern_i2c_scl>),               //                             .i2c_scl
		.hdc1000_extern_i2c_scl_testing       (<connected-to-hdc1000_extern_i2c_scl_testing>),       //                             .i2c_scl_testing
		.hdc1000_extern_i2c_sda               (<connected-to-hdc1000_extern_i2c_sda>),               //                             .i2c_sda
		.hdc1000_extern_i2c_sda_testing       (<connected-to-hdc1000_extern_i2c_sda_testing>),       //                             .i2c_sda_testing
		.hps_0_f2h_cold_reset_req_reset_n     (<connected-to-hps_0_f2h_cold_reset_req_reset_n>),     //     hps_0_f2h_cold_reset_req.reset_n
		.hps_0_f2h_debug_reset_req_reset_n    (<connected-to-hps_0_f2h_debug_reset_req_reset_n>),    //    hps_0_f2h_debug_reset_req.reset_n
		.hps_0_f2h_stm_hw_events_stm_hwevents (<connected-to-hps_0_f2h_stm_hw_events_stm_hwevents>), //      hps_0_f2h_stm_hw_events.stm_hwevents
		.hps_0_f2h_warm_reset_req_reset_n     (<connected-to-hps_0_f2h_warm_reset_req_reset_n>),     //     hps_0_f2h_warm_reset_req.reset_n
		.hps_io_hps_io_emac1_inst_TX_CLK      (<connected-to-hps_io_hps_io_emac1_inst_TX_CLK>),      //                       hps_io.hps_io_emac1_inst_TX_CLK
		.hps_io_hps_io_emac1_inst_TXD0        (<connected-to-hps_io_hps_io_emac1_inst_TXD0>),        //                             .hps_io_emac1_inst_TXD0
		.hps_io_hps_io_emac1_inst_TXD1        (<connected-to-hps_io_hps_io_emac1_inst_TXD1>),        //                             .hps_io_emac1_inst_TXD1
		.hps_io_hps_io_emac1_inst_TXD2        (<connected-to-hps_io_hps_io_emac1_inst_TXD2>),        //                             .hps_io_emac1_inst_TXD2
		.hps_io_hps_io_emac1_inst_TXD3        (<connected-to-hps_io_hps_io_emac1_inst_TXD3>),        //                             .hps_io_emac1_inst_TXD3
		.hps_io_hps_io_emac1_inst_RXD0        (<connected-to-hps_io_hps_io_emac1_inst_RXD0>),        //                             .hps_io_emac1_inst_RXD0
		.hps_io_hps_io_emac1_inst_MDIO        (<connected-to-hps_io_hps_io_emac1_inst_MDIO>),        //                             .hps_io_emac1_inst_MDIO
		.hps_io_hps_io_emac1_inst_MDC         (<connected-to-hps_io_hps_io_emac1_inst_MDC>),         //                             .hps_io_emac1_inst_MDC
		.hps_io_hps_io_emac1_inst_RX_CTL      (<connected-to-hps_io_hps_io_emac1_inst_RX_CTL>),      //                             .hps_io_emac1_inst_RX_CTL
		.hps_io_hps_io_emac1_inst_TX_CTL      (<connected-to-hps_io_hps_io_emac1_inst_TX_CTL>),      //                             .hps_io_emac1_inst_TX_CTL
		.hps_io_hps_io_emac1_inst_RX_CLK      (<connected-to-hps_io_hps_io_emac1_inst_RX_CLK>),      //                             .hps_io_emac1_inst_RX_CLK
		.hps_io_hps_io_emac1_inst_RXD1        (<connected-to-hps_io_hps_io_emac1_inst_RXD1>),        //                             .hps_io_emac1_inst_RXD1
		.hps_io_hps_io_emac1_inst_RXD2        (<connected-to-hps_io_hps_io_emac1_inst_RXD2>),        //                             .hps_io_emac1_inst_RXD2
		.hps_io_hps_io_emac1_inst_RXD3        (<connected-to-hps_io_hps_io_emac1_inst_RXD3>),        //                             .hps_io_emac1_inst_RXD3
		.hps_io_hps_io_sdio_inst_CMD          (<connected-to-hps_io_hps_io_sdio_inst_CMD>),          //                             .hps_io_sdio_inst_CMD
		.hps_io_hps_io_sdio_inst_D0           (<connected-to-hps_io_hps_io_sdio_inst_D0>),           //                             .hps_io_sdio_inst_D0
		.hps_io_hps_io_sdio_inst_D1           (<connected-to-hps_io_hps_io_sdio_inst_D1>),           //                             .hps_io_sdio_inst_D1
		.hps_io_hps_io_sdio_inst_CLK          (<connected-to-hps_io_hps_io_sdio_inst_CLK>),          //                             .hps_io_sdio_inst_CLK
		.hps_io_hps_io_sdio_inst_D2           (<connected-to-hps_io_hps_io_sdio_inst_D2>),           //                             .hps_io_sdio_inst_D2
		.hps_io_hps_io_sdio_inst_D3           (<connected-to-hps_io_hps_io_sdio_inst_D3>),           //                             .hps_io_sdio_inst_D3
		.hps_io_hps_io_usb1_inst_D0           (<connected-to-hps_io_hps_io_usb1_inst_D0>),           //                             .hps_io_usb1_inst_D0
		.hps_io_hps_io_usb1_inst_D1           (<connected-to-hps_io_hps_io_usb1_inst_D1>),           //                             .hps_io_usb1_inst_D1
		.hps_io_hps_io_usb1_inst_D2           (<connected-to-hps_io_hps_io_usb1_inst_D2>),           //                             .hps_io_usb1_inst_D2
		.hps_io_hps_io_usb1_inst_D3           (<connected-to-hps_io_hps_io_usb1_inst_D3>),           //                             .hps_io_usb1_inst_D3
		.hps_io_hps_io_usb1_inst_D4           (<connected-to-hps_io_hps_io_usb1_inst_D4>),           //                             .hps_io_usb1_inst_D4
		.hps_io_hps_io_usb1_inst_D5           (<connected-to-hps_io_hps_io_usb1_inst_D5>),           //                             .hps_io_usb1_inst_D5
		.hps_io_hps_io_usb1_inst_D6           (<connected-to-hps_io_hps_io_usb1_inst_D6>),           //                             .hps_io_usb1_inst_D6
		.hps_io_hps_io_usb1_inst_D7           (<connected-to-hps_io_hps_io_usb1_inst_D7>),           //                             .hps_io_usb1_inst_D7
		.hps_io_hps_io_usb1_inst_CLK          (<connected-to-hps_io_hps_io_usb1_inst_CLK>),          //                             .hps_io_usb1_inst_CLK
		.hps_io_hps_io_usb1_inst_STP          (<connected-to-hps_io_hps_io_usb1_inst_STP>),          //                             .hps_io_usb1_inst_STP
		.hps_io_hps_io_usb1_inst_DIR          (<connected-to-hps_io_hps_io_usb1_inst_DIR>),          //                             .hps_io_usb1_inst_DIR
		.hps_io_hps_io_usb1_inst_NXT          (<connected-to-hps_io_hps_io_usb1_inst_NXT>),          //                             .hps_io_usb1_inst_NXT
		.hps_io_hps_io_spim1_inst_CLK         (<connected-to-hps_io_hps_io_spim1_inst_CLK>),         //                             .hps_io_spim1_inst_CLK
		.hps_io_hps_io_spim1_inst_MOSI        (<connected-to-hps_io_hps_io_spim1_inst_MOSI>),        //                             .hps_io_spim1_inst_MOSI
		.hps_io_hps_io_spim1_inst_MISO        (<connected-to-hps_io_hps_io_spim1_inst_MISO>),        //                             .hps_io_spim1_inst_MISO
		.hps_io_hps_io_spim1_inst_SS0         (<connected-to-hps_io_hps_io_spim1_inst_SS0>),         //                             .hps_io_spim1_inst_SS0
		.hps_io_hps_io_uart0_inst_RX          (<connected-to-hps_io_hps_io_uart0_inst_RX>),          //                             .hps_io_uart0_inst_RX
		.hps_io_hps_io_uart0_inst_TX          (<connected-to-hps_io_hps_io_uart0_inst_TX>),          //                             .hps_io_uart0_inst_TX
		.hps_io_hps_io_i2c0_inst_SDA          (<connected-to-hps_io_hps_io_i2c0_inst_SDA>),          //                             .hps_io_i2c0_inst_SDA
		.hps_io_hps_io_i2c0_inst_SCL          (<connected-to-hps_io_hps_io_i2c0_inst_SCL>),          //                             .hps_io_i2c0_inst_SCL
		.hps_io_hps_io_i2c1_inst_SDA          (<connected-to-hps_io_hps_io_i2c1_inst_SDA>),          //                             .hps_io_i2c1_inst_SDA
		.hps_io_hps_io_i2c1_inst_SCL          (<connected-to-hps_io_hps_io_i2c1_inst_SCL>),          //                             .hps_io_i2c1_inst_SCL
		.hps_io_hps_io_gpio_inst_GPIO09       (<connected-to-hps_io_hps_io_gpio_inst_GPIO09>),       //                             .hps_io_gpio_inst_GPIO09
		.hps_io_hps_io_gpio_inst_GPIO35       (<connected-to-hps_io_hps_io_gpio_inst_GPIO35>),       //                             .hps_io_gpio_inst_GPIO35
		.hps_io_hps_io_gpio_inst_GPIO40       (<connected-to-hps_io_hps_io_gpio_inst_GPIO40>),       //                             .hps_io_gpio_inst_GPIO40
		.hps_io_hps_io_gpio_inst_GPIO48       (<connected-to-hps_io_hps_io_gpio_inst_GPIO48>),       //                             .hps_io_gpio_inst_GPIO48
		.hps_io_hps_io_gpio_inst_GPIO53       (<connected-to-hps_io_hps_io_gpio_inst_GPIO53>),       //                             .hps_io_gpio_inst_GPIO53
		.hps_io_hps_io_gpio_inst_GPIO54       (<connected-to-hps_io_hps_io_gpio_inst_GPIO54>),       //                             .hps_io_gpio_inst_GPIO54
		.hps_io_hps_io_gpio_inst_GPIO61       (<connected-to-hps_io_hps_io_gpio_inst_GPIO61>),       //                             .hps_io_gpio_inst_GPIO61
		.leds_external_connection_export      (<connected-to-leds_external_connection_export>),      //     leds_external_connection.export
		.memory_mem_a                         (<connected-to-memory_mem_a>),                         //                       memory.mem_a
		.memory_mem_ba                        (<connected-to-memory_mem_ba>),                        //                             .mem_ba
		.memory_mem_ck                        (<connected-to-memory_mem_ck>),                        //                             .mem_ck
		.memory_mem_ck_n                      (<connected-to-memory_mem_ck_n>),                      //                             .mem_ck_n
		.memory_mem_cke                       (<connected-to-memory_mem_cke>),                       //                             .mem_cke
		.memory_mem_cs_n                      (<connected-to-memory_mem_cs_n>),                      //                             .mem_cs_n
		.memory_mem_ras_n                     (<connected-to-memory_mem_ras_n>),                     //                             .mem_ras_n
		.memory_mem_cas_n                     (<connected-to-memory_mem_cas_n>),                     //                             .mem_cas_n
		.memory_mem_we_n                      (<connected-to-memory_mem_we_n>),                      //                             .mem_we_n
		.memory_mem_reset_n                   (<connected-to-memory_mem_reset_n>),                   //                             .mem_reset_n
		.memory_mem_dq                        (<connected-to-memory_mem_dq>),                        //                             .mem_dq
		.memory_mem_dqs                       (<connected-to-memory_mem_dqs>),                       //                             .mem_dqs
		.memory_mem_dqs_n                     (<connected-to-memory_mem_dqs_n>),                     //                             .mem_dqs_n
		.memory_mem_odt                       (<connected-to-memory_mem_odt>),                       //                             .mem_odt
		.memory_mem_dm                        (<connected-to-memory_mem_dm>),                        //                             .mem_dm
		.memory_oct_rzqin                     (<connected-to-memory_oct_rzqin>),                     //                             .oct_rzqin
		.mpu9250_extern_sdo                   (<connected-to-mpu9250_extern_sdo>),                   //               mpu9250_extern.sdo
		.mpu9250_extern_cs                    (<connected-to-mpu9250_extern_cs>),                    //                             .cs
		.mpu9250_extern_fsync                 (<connected-to-mpu9250_extern_fsync>),                 //                             .fsync
		.mpu9250_extern_sclk                  (<connected-to-mpu9250_extern_sclk>),                  //                             .sclk
		.mpu9250_extern_sdi                   (<connected-to-mpu9250_extern_sdi>),                   //                             .sdi
		.mpu9250_extern_sclk_dbg              (<connected-to-mpu9250_extern_sclk_dbg>),              //                             .sclk_dbg
		.mpu9250_extern_sdi_dbg               (<connected-to-mpu9250_extern_sdi_dbg>),               //                             .sdi_dbg
		.mpu9250_extern_sdo_dbg               (<connected-to-mpu9250_extern_sdo_dbg>),               //                             .sdo_dbg
		.mpu9250_extern_cs_dbg                (<connected-to-mpu9250_extern_cs_dbg>),                //                             .cs_dbg
		.reset_reset_n                        (<connected-to-reset_reset_n>),                        //                        reset.reset_n
		.seven_segment_conduit_end_export     (<connected-to-seven_segment_conduit_end_export>),     //    seven_segment_conduit_end.export
		.switches_external_connection_export  (<connected-to-switches_external_connection_export>)   // switches_external_connection.export
	);

