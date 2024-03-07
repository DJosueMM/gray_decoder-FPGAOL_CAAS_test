

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

## Load the bitstream into the FPGA

Follow these steps to load the bitstream into the FPGA:

1. Once the bitstream generation is completed in the previous section, the following functions will be available:

    ![Fetch and show log](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/6a87b2d1-61c8-4dce-a27b-1ca152deac81)

    - **Fetch and show log**: Displays the data of the logical and physical synthesis process. If an error occurs during the bitstream generation, the synthesis will fail, and the error can be consulted with this option.
   
    - **Download log**: Downloads the text file containing all the data of the synthesis process.
   
    - **Download bitstream**: Downloads the generated bitstream in .fs or .bit format.

2. Additional steps are required for the "Program bitstream" option:

    a. **Modify the USB driver on Windows**: If you have already done this on your computer, you can skip this step. Otherwise, refer to the [Windows USB driver configuration here](https://github.com/DJosueMM/open_source_fpga_environment#configuraci%C3%B3n-del-driver-usb-de-windows). This step is done only once.


   b. After modifying the USB driver, connect the FPGA to the USB port and follow these steps:

   1. Press the `Connect Local USB` button.
 
      ![Connect Local USB](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/a2dd684d-ebda-4e94-b127-fd561fc57d10)
      

   2. Select `JTAG Debugger` in the appearing window.
      
      ![JTAG Debugger](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/9b4a50cc-2d34-47a5-8b64-db841613cd6b)
      

   3. Press the `Detect FPGA` button to establish the connection with the FPGA.

      ![Detect FPGA](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/be782336-1adc-4667-8c73-9012c0d742d9)
 

   4. Finally, press `Program Bitstream...`.
   
      ![Program Bitstream](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/e06bc000-50d0-4044-9f39-c281b5d06460)


This concludes the tutorial.


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

Para realizar la síntesis de los módulos, sigue estos pasos:

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

## Cargar el bitstream en la FPGA

Siga estos pasos para cargar el bitstream en la FPGA:

1. Una vez que se haya completado la generación del bitstream en la sección anterior, se tendrán disponibles las siguientes funciones:

    ![Fetch and show log](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/6a87b2d1-61c8-4dce-a27b-1ca152deac81)
   
    - **Fetch and show log**: Muestra los datos del proceso de síntesis lógica y física. Si ocurre un error durante la generación del bitstream, la síntesis fallará y se podrá consultar el error con esta opción.
   
    - **Download log**: Descarga el archivo de texto que contiene todos los datos del proceso de síntesis.
   
    - **Download bitstream**: Descarga el bitstream generado en formato .fs o .bit.

2. Para la opción "Program bitstream", se necesitan los siguientes pasos adicionales:

    a. **Modificar el driver USB en Windows**: si ya hizo esto en la computadora puede omitirlo, de lo contrario, consulte la [configuración del driver USB de Windows aquí](https://github.com/DJosueMM/open_source_fpga_environment#configuraci%C3%B3n-del-driver-usb-de-windows), este paso se hace una única vez. 

   b. Después de modificar el driver USB, conecte la FPGA al puerto USB y siga estos pasos:

   1. Presione el botón `Connect Local USB`.
 
      ![Connect Local USB](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/a2dd684d-ebda-4e94-b127-fd561fc57d10)
      

   3. Seleccione `JTAG Debugger` en la ventana que aparece.
      
      ![JTAG Debugger](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/9b4a50cc-2d34-47a5-8b64-db841613cd6b)
      

   4. Presione el botón `Detect FPGA` para establecer la conexión con la FPGA.

      ![Detect FPGA](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/be782336-1adc-4667-8c73-9012c0d742d9)
 

   5. Por último, presione `Program Bitstream...`.
   
      ![Program Bitstream](https://github.com/DJosueMM/gray_decoder-FPGAOL_CAAS_test/assets/81501061/e06bc000-50d0-4044-9f39-c281b5d06460)


Con esto se da por concluido el tutorial.

