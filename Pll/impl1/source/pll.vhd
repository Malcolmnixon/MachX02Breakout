-------------------------------------------------------------------------------
--! @file
--! @brief Basic top-level blinky LED module
-------------------------------------------------------------------------------

--! Using IEEE library
LIBRARY ieee;

--! Using IEEE standard logic components
USE ieee.std_logic_1164.ALL;

--! @brief Blinky LED top-level entity
ENTITY pll IS
    PORT (
        leds_out : OUT   std_logic_vector(7 DOWNTO 0) --! LED outputs
    );
END ENTITY pll;

--! Architecture behavior of pll entity
ARCHITECTURE behavior OF pll IS

    SIGNAL osc   : std_logic; --! Internal oscillator (9.85MHz)
    SIGNAL lock  : std_logic; --! PLL Lock 
    SIGNAL clk   : std_logic; --! Main clock (98.5MHz)
    SIGNAL rst   : std_logic; --! Reset
    SIGNAL state : std_logic; --! Toggle state
    
    --! Component declaration for the MachX02 internal oscillator
    COMPONENT osch IS
        GENERIC (
            nom_freq : string := "9.85"
        );
        PORT ( 
            stdby    : IN    std_logic;
            osc      : OUT   std_logic;
            sedstdby : OUT   std_logic
        );
    END COMPONENT osch;

    --! Component delcaration for the PLL
    COMPONENT mc_pll IS
        PORT (
            clki  : IN    std_logic;
            clkop : OUT   std_logic;
            lock  : OUT   std_logic
        );
    END COMPONENT mc_pll;

BEGIN

    --! Instantiate the internal oscillator for 9.85MHz 
    i_osch : osch
        GENERIC MAP (
            nom_freq => "9.85"
        )
        PORT MAP (
            stdby    => '0',
            osc      => osc,
            sedstdby => OPEN
        );

    --! Instantiate the PLL (9.85MHz -> 98.5MHz)
    i_pll : mc_pll
        PORT MAP (
            clki  => osc,
            clkop => clk,
            lock  => lock
        );

    --! Instantiate the toggle component
    i_toggle : ENTITY work.toggle(behavior)
        GENERIC MAP (
            max_count => 49_250_000 - 1
        )
        PORT MAP (
            clk_in  => clk,
            rst_in  => rst,
            sig_out => state
        );
    
    --! Hold in reset until locked
    rst <= NOT lock;
    
    -- Update LEDs
    leds_out(0) <= state;
    leds_out(1) <= state;
    leds_out(2) <= state;
    leds_out(3) <= state;
    leds_out(4) <= state;
    leds_out(5) <= state;
    leds_out(6) <= state;
    leds_out(7) <= state;

END ARCHITECTURE behavior;
