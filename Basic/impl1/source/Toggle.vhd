-------------------------------------------------------------------------------
--! @file
--! @brief Toggle generator
-------------------------------------------------------------------------------

--! Using IEEE library
LIBRARY ieee;

--! Using IEEE standard logic components
USE ieee.std_logic_1164.ALL;

--! @brief Toggle entity
--!
--! This entity counts clocks, and toggles the output every time the counter
--! reaches the specified max_count value.
ENTITY toggle IS
    GENERIC (
        max_count : integer := 10 --! Maximum Count value
    );
    PORT (
        clk_in  : IN    std_logic; --! Clock
        rst_in  : IN    std_logic; --! Reset flag
        sig_out : OUT   std_logic  --! Toggling Signal flag
    );
END ENTITY toggle;

--! Architecture behavior of toggle entity
ARCHITECTURE behavior OF toggle IS

    --! Internal counter
    SIGNAL count : integer RANGE 0 TO max_count;
    
    --! Current state
    SIGNAL state : std_logic;
    
    --! Terminal count flag
    SIGNAL tc : std_logic;
    
BEGIN

    --! @brief Process to count and toggle
    --!
    --! This process counts clocks and toggles the state when appropriate.
    pr_count : PROCESS (clk_in) IS
    BEGIN
    
        IF (rising_edge(clk_in)) THEN
            IF (rst_in = '1') THEN
                count <= 0;
                state <= '0';
            ELSIF (count = max_count) THEN
                count <= 0;
                state <= NOT state;
            ELSE
                count <= count + 1;
            END IF;
        END IF;
        
    END PROCESS pr_count;
    
    sig_out <= state;
    
END ARCHITECTURE behavior;
