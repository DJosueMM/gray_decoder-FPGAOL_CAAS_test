

- [🅴 English](#Gray-to-Binary-and-Decimal-Decoder-for-TangNano9k-FPGA)
- [🅴🆂 Español](#Decodificador-de-gray-a-binario-y-decimal-en-la-FPGA-TangNano9k)


## Gray to Binary and Decimal Decoder for TangNano9k FPGA
In this project, the user inputs a 4-bit Gray code to be decoded into binary on LEDs and displayed in decimal on a multiplexed 7-segment display.

The following image shows the schematic of the circuit.

![image](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/fda98234-75f9-49ed-a039-8a3e77e8f012)

The connections should correspond to the constraints of the project found in `/src/design/module_deco_gray.cst`

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

### Design synthesis and programming the FPGA on the Caas platform

To perform synthesis and programming of the FPGA on the Caas platform, follow these steps:

1. Go to https://caas.symbioticeda.com/ and select the `GitHub Project` mode as shown in the following image:

![Screenshot from 2024-03-06 11-49-55](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/018297c1-62cd-4594-9083-89027b3f4d6a)

2. Enter the repository link where the modules to be synthesized are located: `https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/tree/main/src/design` in the space indicated by the red arrow.

![Screenshot from 2024-03-06 12-08-00](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/9d23e3e3-6b46-47e2-8507-784426d819ff)

3. Fill in the fields at the top with the following information:
   - Name: the name to be given to the bitstream, for example `deco_gray_tangnano9k`
   - FPGA part: the FPGA to be used, in this case `GW1NR-LV9QN88PC6\/I5`
   - Backend: associated with the FPGA, in this case `gowin`
   - Top module: the top module of the design, in this case `module_top_deco_gray`

4. Finally, select the checkbox for `Use existing config file` indicated by the yellow arrow. This file is located in `/src/design/caas.conf`.

```Verilog
[caas]
Server = https://caas.symbioticeda.com:18888/

[project]
Backend = gowin
Part = GW1NR-LV9QN88PC6\/I5
Top = module_top_deco_gray
Bitname = top.fs
Sources = module_7_segments.v, module_bin_to_bcd.v, module_input_deco_gray.v, module_top_deco_gray.v

```

This file contains all the information we entered earlier and the modules to be synthesized. If this file does not exist in the repository sources, the information must be entered manually.

After completing the steps, the configuration should look like the following image, then press `Submit`.

![Screenshot from 2024-03-06 12-35-53](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/e837fdb6-678b-4685-b04c-21cb59d59460)


## Decodificador de gray a binario y decimal en la FPGA TangNano9k
En este proyecto, el usuario ingresa un código Gray de 4 bits que se decodifica en binario en LEDs y se muestra en decimal en un display de 7 segmentos multiplexado.

La siguiente imagen muestra el esquemático del circuito.

![imagen](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/fda98234-75f9-49ed-a039-8a3e77e8f012)

Las conexiones deben corresponder a las restricciones del proyecto que se encuentran en `/src/design/module_deco_gray.cst`.

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

### Síntesis del diseño y programación de la FPGA en la plataforma Caas

Para realizar la síntesis y programación de la FPGA en la plataforma Caas, sigue estos pasos:

1. Ingresa a https://caas.symbioticeda.com/ y selecciona el modo `GitHub Project` como se muestra en la siguiente imagen:

![Captura de pantalla del 2024-03-06 11-49-55](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/018297c1-62cd-4594-9083-89027b3f4d6a)

2. Ingresa el enlace del repositorio donde se encuentran los módulos a sintetizar: `https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/tree/main/src/design` en el espacio indicado por la flecha roja.

![Captura de pantalla del 2024-03-06 12-08-00](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/9d23e3e3-6b46-47e2-8507-784426d819ff)

3. Llena los campos en la parte superior con la siguiente información:
   - Name: el nombre que se le dará al flujo de bits, por ejemplo `deco_gray_tangnano9k`
   - FPGA part: el FPGA que se utilizará, en este caso `GW1NR-LV9QN88PC6\/I5`
   - Backend: asociado al FPGA, en este caso `gowin`
   - Top module: el módulo top del diseño, en este caso `module_top_deco_gray`

4. Finalmente, selecciona la casilla `Use existing config file` indicada por la flecha amarilla. Este archivo se encuentra en `/src/design/caas.conf`.
   
```Verilog
[caas]
Server = https://caas.symbioticeda.com:18888/

[project]
Backend = gowin
Part = GW1NR-LV9QN88PC6\/I5
Top = module_top_deco_gray
Bitname = top.fs
Sources = module_7_segments.v, module_bin_to_bcd.v, module_input_deco_gray.v, module_top_deco_gray.v

```
Este archivo contiene toda la información que ingresamos anteriormente y los módulos a sintetizar. Si este archivo no existe en las fuentes del repositorio, la información debe ingresarse manualmente.

Después de completar los pasos, la configuración debería lucir como en la siguiente imagen, luego presiona `Submit`.

![Captura de pantalla del 2024-03-06 12-35-53](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/e837fdb6-678b-4685-b04c-21cb59d59460)


