-------------------------------------------------------------------------------
--! @file
--! @brief Basic top-level blinky LED module
-------------------------------------------------------------------------------

--! Using IEEE library
LIBRARY ieee;

--! Using IEEE standard logic components
USE ieee.std_logic_1164.ALL;

--! @brief Blinky LED top-level entity
ENTITY basic IS
    PORT (
        leds_out : OUT   std_logic_vector(7 DOWNTO 0) --! LED outputs
    );
END ENTITY basic;

--! Architecture rtl of basic entity
ARCHITECTURE rtl OF basic IS

    --! Main clock (9.85MHz)
    SIGNAL clk : std_logic;
    
    --! Toggle state
    SIGNAL state : std_logic;
    
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

BEGIN

    --! Instantiate the internal oscillator for 9.85MHz 
    i_osch : osch
        GENERIC MAP (
            nom_freq => "9.85"
        )
        PORT MAP (
            stdby    => '0',
            osc      => clk,
            sedstdby => OPEN
        );

    --! Instantiate the toggle component
    i_toggle : ENTITY work.toggle(rtl)
        GENERIC MAP (
            max_count => 4_925_000 - 1
        )
        PORT MAP (
            clk_in  => clk,
            rst_in  => '0',
            sig_out => state
        );
    
    -- Update LEDs
    leds_out(0) <= state;
    leds_out(1) <= state;
    leds_out(2) <= state;
    leds_out(3) <= state;
    leds_out(4) <= state;
    leds_out(5) <= state;
    leds_out(6) <= state;
    leds_out(7) <= state;

END ARCHITECTURE rtl;
