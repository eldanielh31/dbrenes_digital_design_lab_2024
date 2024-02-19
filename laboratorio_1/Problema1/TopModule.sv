module TopModule(
   input wire [3:0] binary_input, // 4 bits input
   output wire [7:0] bcd_output // 8 bits output
);

   // Instancia del decodificador BCD
   Bin_BCD bin_bcd_inst (
      .binary_input(binary_input),
      .bcd_output(bcd_output)
   );

   // Instancia del módulo para mostrar en siete segmentos
   seven_segments seven_seg_display_inst (
      .bcd_input(bcd_output),  // Conecta la salida BCD al siete segmentos
      .seven_seg(segment_output)
   );

   // Asegúrate de inicializar o cambiar binary_input para probar diferentes valores

endmodule	