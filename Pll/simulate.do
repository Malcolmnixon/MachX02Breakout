# Set error handling
onerror {quit}

# Create library
alib work

# Set as working library
set worklib work

# Compile source files
acom -dbg -2008 impl1/source/Toggle.vhd
acom -dbg -2008 impl1/sim/Toggle_tb.vhd

# Start the simulation
asim toggle_tb

# Run the simulation
run

# Close the simulation
endsim
quit
