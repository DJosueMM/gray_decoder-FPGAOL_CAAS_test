# Gray to Binary and Decimal Decoder for TangNano9k FPGA

In this project, the user inputs a 4-bit Gray code to be decoded into binary on LEDs and displayed in decimal on a multiplexed 7-segment display.

En la siguiente imagen se muestra el esquematico del circuito.

![image](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/fda98234-75f9-49ed-a039-8a3e77e8f012)

Las conexiones deben corresponder con las constraints del proyecto que se encuentran en `/src/design/module_deco_gray.cst`

```Verilog

IO_LOC  "catodo_po[6]"  29;
IO_PORT "catodo_po[6]"  IO_TYPE=LVCMOS33; //Cathode g

IO_LOC  "catodo_po[5]" 30;
IO_PORT "catodo_po[5]" IO_TYPE=LVCMOS33; //Cathode f

IO_LOC  "catodo_po[0]" 51;
IO_PORT "catodo_po[0]" IO_TYPE=LVCMOS33; //Cathode e

IO_LOC  "catodo_po[1]" 42;
IO_PORT "catodo_po[1]" IO_TYPE=LVCMOS33; //Cathode d

IO_LOC  "catodo_po[4]" 53;
IO_PORT "catodo_po[4]" IO_TYPE=LVCMOS33; //Cathode c

IO_LOC  "catodo_po[3]" 54;
IO_PORT "catodo_po[3]" IO_TYPE=LVCMOS33; //Cathode b

IO_LOC  "catodo_po[2]" 55;
IO_PORT "catodo_po[2]" IO_TYPE=LVCMOS33; //Cathode a

IO_LOC  "anodo_po[1]" 57;
IO_PORT "anodo_po[1]" IO_TYPE=LVCMOS33; //anode digit 1

IO_LOC  "anodo_po[0]" 56;
IO_PORT "anodo_po[0]" IO_TYPE=LVCMOS33; //anode digit 0

IO_LOC  "clk_pi" 52;
IO_PORT "clk_pi" IO_TYPE=LVCMOS33 PULL_MODE=UP; // internal clock 27 MHz

IO_LOC  "rst_pi" 3;
IO_PORT "rst_pi" IO_TYPE=LVCMOS18; // BTN reset

IO_LOC  "codigo_bin_led_po[0]" 10;
IO_PORT "codigo_bin_led_po[0]" DRIVE=8 IO_TYPE=LVCMOS18 PULL_MODE=DOWN; //Led [0]

IO_LOC  "codigo_bin_led_po[1]" 11;
IO_PORT "codigo_bin_led_po[1]" DRIVE=8 IO_TYPE=LVCMOS18 PULL_MODE=DOWN; //Led [1]

IO_LOC  "codigo_bin_led_po[2]" 13;
IO_PORT "codigo_bin_led_po[2]" DRIVE=8 IO_TYPE=LVCMOS18 PULL_MODE=DOWN; //Led [2] 

IO_LOC  "codigo_bin_led_po[3]" 14;
IO_PORT "codigo_bin_led_po[3]" DRIVE=8 IO_TYPE=LVCMOS18 PULL_MODE=DOWN; //Led [3]

IO_LOC  "codigo_gray_pi[0]" 28;
IO_PORT "codigo_gray_pi[0]" IO_TYPE=LVCMOS33 PULL_MODE=DOWN;  //Input gray [0]

IO_LOC  "codigo_gray_pi[1]" 27;
IO_PORT "codigo_gray_pi[1]" IO_TYPE=LVCMOS33 PULL_MODE=DOWN; //Input gray [1]

IO_LOC  "codigo_gray_pi[2]" 26;
IO_PORT "codigo_gray_pi[2]" IO_TYPE=LVCMOS33 PULL_MODE=DOWN; //Input gray [2]

IO_LOC  "codigo_gray_pi[3]" 25;
IO_PORT "codigo_gray_pi[3]" IO_TYPE=LVCMOS33 PULL_MODE=DOWN; //Input gray [3]
```

# Design synthesis and programming the fpga on the cass platform

La ruta del repositorio donde estan los modulos a sintetizar es: https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/tree/main/src/design

Se debe ingresar a https://caas.symbioticeda.com/

