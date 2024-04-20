module main_testbench;

    // Inputs
    reg clock;
    reg reset;
    reg direction;
    reg move_h;
    reg move_v;
    reg fire;
    reg place_boat;
    reg [2:0] amount_boats;

    // Outputs
    wire led;
    wire [6:0] segAmount;
    wire [6:0] segPlayer;
    wire [6:0] segPc;
    wire [7:0] red;
    wire [7:0] green;
    wire [7:0] blue;
    wire vgaclock;
    wire hsync;
    wire vsync;
    wire n_blank;

    // Instantiate the Unit Under Test (UUT)
    main uut (
        .clock(clock), 
        .reset(reset), 
        .direction(direction), 
        .move_h(move_h), 
        .move_v(move_v), 
        .fire(fire), 
        .place_boat(place_boat), 
        .amount_boats(amount_boats), 
        .led(led), 
        .segAmount(segAmount), 
        .segPlayer(segPlayer), 
        .segPc(segPc), 
        .red(red), 
        .green(green), 
        .blue(blue), 
        .vgaclock(vgaclock), 
        .hsync(hsync), 
        .vsync(vsync), 
        .n_blank(n_blank)
    );

    initial begin
        // Initialize Inputs
        clock = 0;
        reset = 0;
        direction = 0;
        move_h = 0;
        move_v = 0;
        fire = 0;
        place_boat = 0;
        amount_boats = 0;

        #20;
		  
		  $finish;

    end
      
    // Clock generation
    always #5 clock = ~clock;

endmodule
