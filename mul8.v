//`timescale 1ns / 1ps

//module fsm(input wire clk, input wire  rst, input wire start, input wire  [7:0]   mc, input wire  [7:0]   mp, output reg  [15:0]  pro, output wire done);
//    wire        pp;
//    reg [7:0]   Y;
//    reg         sign_mp;  // Store the sign bit of mp
//    reg [4:0]   cnt, ncnt;
//    reg [1:0]   state, nstate;

//    localparam  IDLE=0, RUNNING=1, DONE=2;

//    always @(posedge clk or posedge rst)
//        if(rst)
//            state  <= IDLE;
//        else 
//            state <= nstate;
    
//    always @*
//        case(state)
//            IDLE    :   if(start) nstate = RUNNING; else nstate = IDLE;
//            RUNNING :   if(cnt == 16) nstate = DONE; else nstate = RUNNING; 
//            DONE    :   if(start) nstate = RUNNING; else nstate = DONE;
//            default :   nstate = IDLE;
//        endcase
    
//    always @(posedge clk)
//        cnt <= ncnt;

//    always @*
//        case(state)
//            IDLE    :   ncnt = 0;
//            RUNNING :   ncnt = cnt + 1;
//            DONE    :   ncnt = 0;
//            default :   ncnt = 0;
//        endcase

//    // Store sign bit of mp when starting
//    always @(posedge clk or posedge rst)
//        if(rst)
//            sign_mp <= 1'b0;
//        else if(start)
//            sign_mp <= mp[7];  // Store the sign bit

//    // Modified Y register handling with sign extension
//    always @(posedge clk or posedge rst)
//        if(rst)
//            Y <= 8'b0;
//        else if(start)
//            Y <= mp;
//        else if(state==RUNNING) begin
//            // Shift with sign extension when count >= 8
//            if(cnt >= 7)
//                Y <= {sign_mp, Y[7:1]};
//            else
//                Y <= {Y[7], Y[7:1]};  // Normal right shift with sign extension
//        end

//    always @(posedge clk)
//        if(start | rst)
//            pro <= 16'b0;
//        else if(state==RUNNING)
//            pro <= {pp, pro[15:1]};

//    wire ss = (state==RUNNING) ? Y[0] : 1'b0;

//    spm spm8(.clk(clk),.rst(rst),
//        .x(mc),
//        .y(ss),
//        .p(pp)
//    );

//    assign done = (state == DONE);

//endmodule
`timescale 1ns / 1ps

module fsm(input wire clk, input wire  rst, input wire start, input wire  [7:0]   mc, input wire  [7:0]   mp, output reg  [15:0]  pro, output wire done);
    wire        pp;
    reg [7:0]   Y;
    reg         sign_mp;  // Store the sign bit of mp
    reg [4:0]   iter, nextiter;
    reg [1:0]   state, next;

    localparam  INACTIVE=0, MULTIPLY=1, DONE=2;

    always @(posedge clk or posedge rst)
        if(rst)
            state  <= INACTIVE;
        else 
            state <= next;
    
    always @*
        case(state)
            INACTIVE    :   if(start) next = MULTIPLY; else next = INACTIVE;
            MULTIPLY :   if(iter == 16) next = DONE; else next = MULTIPLY; 
            DONE    :   if(start) next = MULTIPLY; else next = DONE;
            default :   next = INACTIVE;
        endcase
    
    always @(posedge clk)
        iter <= nextiter;

    always @*
        case(state)
            INACTIVE:   nextiter = 0;
            MULTIPLY:   nextiter = iter + 1;
            DONE:   nextiter = 0;
            default:   nextiter = 0;
        endcase

    // Store sign bit of mp when starting
    always @(posedge clk or posedge rst)
        if(rst)
            sign_mp <= 1'b0;
        else if(start)
            sign_mp <= mp[7];  // Store the sign bit

    // Modified Y register handling with sign extension
    always @(posedge clk or posedge rst)
        if(rst)
            Y <= 8'b0;
        else if(start)
            Y <= mp;
        else if(state==MULTIPLY) begin
            // Shift with sign extension when count >= 8
            if(iter >= 7)
                Y <= {sign_mp, Y[7:1]};
            else
                Y <= {Y[7], Y[7:1]};  // Normal right shift with sign extension
        end

    always @(posedge clk)
        if(start | rst)
            pro <= 16'b0;
        else if(state==MULTIPLY)
            pro <= {pp, pro[15:1]};

    wire si = (state==MULTIPLY) ? Y[0] : 1'b0;

    spm spm8(.clk(clk),.rst(rst),.x(mc),.y(si),.p(pp));

    assign done = (state == DONE);

endmodule

