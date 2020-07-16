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
        leds_out : OUT std_logic_vector(7 DOWNTO 0)     --! LED outputs
    );
END ENTITY basic;

--! Architecture behavior of basic entity
ARCHITECTURE behavior OF basic IS

    --! Main clock (9.85MHz)
    SIGNAL clk : std_logic;
    
    --! Toggle signal
    SIGNAL toggle : std_logic;
    
    --! Component declaration for the MachX02 internal oscillator
    COMPONENT osch
        GENERIC (
            nom_freq : string := "9.85"                 --! Nominal frequency
        );
        PORT ( 
            stdby    : IN    std_logic;                 --! Standby flag (0 = active, 1 = off)
            osc      : OUT   std_logic;                 --! Clock output
            sedstdby : OUT   std_logic                  --! Standby for simulation
        );
   END COMPONENT osch;

BEGIN

    --! Instantiate the internal oscillator for 9.85MHz 
    i_osch : osch
        GENERIC MAP (
            nom_freq => "9.85"                          --! Nominal frequency
        )
        PORT MAP (
            stdby    => '0',                            --! Active
            osc      => clk,                            --! Clock
            sedstdby => OPEN                            --! Unused
        );

    --! @brief Toggle process
    --!
    --! This process counts the 9.85MHz clock and toggles the toggle signal
    --! every 1/2 second
    pr_toggle : PROCESS ( clk ) IS
    
        --! Clock counter
        VARIABLE v_count : integer RANGE 0 TO 4925000 := 0;
        
    BEGIN
    
        IF (rising_edge(clk)) THEN
            if (v_count = 4925000) THEN
                v_count := 0;               -- Reset count
                toggle <= NOT toggle;       -- Toggle
            ELSE
                v_count := v_count + 1;     -- Increment count
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
