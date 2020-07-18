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

    SIGNAL osc    : std_logic; --! Internal oscillator (9.85MHz)
    SIGNAL clk    : std_logic; --! Main clock (98.5MHz)
    SIGNAL lock   : std_logic; --! PLL Lock 
    SIGNAL toggle : std_logic; --! Toggle signal
    
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

    --! Instantiate the PLL
    i_pll : mc_pll
        PORT MAP (
            clki  => osc,
            clkop => clk,
            lock  => lock
        );
            
    --! @brief Toggle process
    --!
    --! This process counts the 98.5MHz clock and toggles the toggle signal
    --! every 1/2 second
    pr_toggle : PROCESS (clk) IS
    
        --! Clock counter
        VARIABLE v_count : integer RANGE 0 TO 49_250_000;
        
    BEGIN
    
        IF (rising_edge(clk)) THEN
            IF (v_count = 49_250_000) THEN
                v_count := 0;           -- Reset count
                toggle <= NOT toggle;   -- Toggle
            ELSE
                v_count := v_count + 1; -- Increment count
            END IF;
        END IF;
        
    END PROCESS pr_toggle;
    
    -- Update LEDs
    leds_out(0) <= toggle;
    leds_out(1) <= toggle;
    leds_out(2) <= toggle;
    leds_out(3) <= toggle;
    leds_out(4) <= toggle;
    leds_out(5) <= toggle;
    leds_out(6) <= toggle;
    leds_out(7) <= toggle;

END ARCHITECTURE behavior;
