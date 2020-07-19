-------------------------------------------------------------------------------
--! @file
--! @brief Toggle testbench
-------------------------------------------------------------------------------

--! Using IEEE library
LIBRARY ieee;

--! Using IEEE standard logic components
USE ieee.std_logic_1164.ALL;

--! @brief Toggle testbench
ENTITY toggle_tb IS
END ENTITY toggle_tb;

--! Architecture tb of toggle_tb entity
ARCHITECTURE tb OF toggle_tb IS

    --! Clock period constant
    CONSTANT c_clk_period : time := 10ns;
    
    SIGNAL clk : std_logic; --! Clock signal
    SIGNAL rst : std_logic; --! Reset signal
    SIGNAL sig : std_logic; --! Toggle signal

BEGIN

    --! Instantiate the toggle component
    i_uut : ENTITY work.toggle(rtl)
        GENERIC MAP (
            max_count => 2
        )
        PORT MAP (
            clk_in  => clk,
            rst_in  => rst,
            sig_out => sig
        );
        
    --! @brief Clock generator process
    pr_clk : PROCESS IS
    BEGIN
        
        -- Low for 1/2 clock
        clk <= '0';
        WAIT FOR c_clk_period / 2;
        
        -- High for 1/2 clock
        clk <= '1';
        WAIT FOR c_clk_period / 2;
        
    END PROCESS pr_clk;
    
    --! @brief Test bench stimulus process
    pr_stimulus : PROCESS IS
    BEGIN
    
        --! Put in reset and verify low
        rst <= '1';
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect low while in reset" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect low while in reset" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect low while in reset" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect low while in reset" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect low while in reset" SEVERITY warning;
        
        --! Take out of reset and verify toggling
        rst <= '0';
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect sig = '0' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect sig = '0' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '1') REPORT "Expect sig = '1' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '1') REPORT "Expect sig = '1' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '1') REPORT "Expect sig = '1' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect sig = '0' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect sig = '0' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect sig = '0' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '1') REPORT "Expect sig = '1' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '1') REPORT "Expect sig = '1' at this point of toggle" SEVERITY warning;
        
        --! Put into reset and verify low
        rst <= '1';
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect low while in reset" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect low while in reset" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect low while in reset" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect low while in reset" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect low while in reset" SEVERITY warning;
        
        --! Take out of reset and verify toggling
        rst <= '0';
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect sig = '0' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect sig = '0' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '1') REPORT "Expect sig = '1' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '1') REPORT "Expect sig = '1' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '1') REPORT "Expect sig = '1' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect sig = '0' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect sig = '0' at this point of toggle" SEVERITY warning;
        WAIT FOR c_clk_period;
        ASSERT (sig = '0') REPORT "Expect sig = '0' at this point of toggle" SEVERITY warning;
    
        -- Finish the simulation
        std.env.finish;
        
    END PROCESS pr_stimulus;
    
END ARCHITECTURE tb;
