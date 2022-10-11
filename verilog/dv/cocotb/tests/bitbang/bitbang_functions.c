

void clock11()
{
    reg_mprj_xfer = 0x66; reg_mprj_xfer = 0x76;
}

void clock00()
{
    reg_mprj_xfer = 0x06; reg_mprj_xfer = 0x16;
}

// --------------------------------------------------------

void clock10()
{
    reg_mprj_xfer = 0x46; reg_mprj_xfer = 0x56;
}

void clock01()
{
    reg_mprj_xfer = 0x26; reg_mprj_xfer = 0x36;
}

// --------------------------------------------------------
// Load registers
// --------------------------------------------------------

void load()
{
    reg_mprj_xfer = 0x06;
    reg_mprj_xfer = 0x0e; reg_mprj_xfer = 0x06;		// Apply load
}

// --------------------------------------------------------
// Enable bit-bang mode and clear registers
// --------------------------------------------------------

void clear_registers()
{
    reg_mprj_xfer = 0x06;			// Enable bit-bang mode
    reg_mprj_xfer = 0x04; reg_mprj_xfer = 0x06;	// Pulse reset
}

// --------------------------------------------------------
// Clock in an input + output configuration.  The value
// passed in "ddhold" is the number of data-dependent hold
// violations up to this point.
// --------------------------------------------------------

/* Clock in data on the left side.  Assume standard hold
 * violation, so clock in12 times and assume that the
 * next data to be clocked will start with "1", enforced
 * by the code.
 *
 * Left side = GPIOs 37 to19
 */

void clock_in_left_short(uint32_t ddhold)
{
    uint32_t count;
    uint32_t holds = ddhold;

    clock10();
    clock10();

    for (count = 0; count < 9; count++) {
	if (holds != 0) {
	    clock10();
	    holds--;
	}
	else
	    clock00();
    }

    clock00();
}

/* Clock in data on the right side.  Assume standard hold
 * violation, so clock in12 times and assume that the
 * next data to be clocked will start with "1", enforced
 * by the code.
 *
 * Right side = GPIOs 0 to18
 */

void clock_in_right_short(uint32_t ddhold)
{
    uint32_t count;
    uint32_t holds = ddhold;

    clock01();
    clock01();

    for (count = 0; count < 9; count++) {
	if (holds != 0) {
	    clock01();
	    holds--;
	}
	else
	    clock00();
    }

    clock00();
}

/* Clock in data on the left side.  Clock the normal13 times,
 * which is correct for no hold violation or for a data-
 * dependent hold violation (for the latter, ddhold must be
 * incremented before calling the subroutine).
 *
 * Left side = GPIOs 37 to19
 */

void clock_in_left_standard(uint32_t ddhold){
    uint32_t count;
    uint32_t holds = ddhold;

    clock10();
    clock10();

    for (count = 0; count < 7; count++) {
	if (holds != 0) {
	    clock10();
	    holds--;
	}
	else
	    clock00();
    }

    clock10();
    clock00();    
    clock00();
    clock10();
}
void clock_in_right_o_left_o_standard(uint32_t ddhold){
    uint32_t count;
    uint32_t holds = ddhold;

    clock11();
    clock11();

    for (count = 0; count < 7; count++) {
	if (holds != 0) {
	    clock11();
	    holds--;
	}
	else
	    clock00();
    }

    clock11();
    clock00();    
    clock00();
    clock11();
}

void clock_in_right_o_left_i_standard(uint32_t ddhold){
    uint32_t count;
    uint32_t holds = ddhold;

    clock11();
    clock11();

    for (count = 0; count < 7; count++) {
	if (holds != 0) {
	    clock11();
	    holds--;
	}
	else
	    clock00();
    }

    clock10();
    clock00();    
    clock01();
    clock11();
}

void clock_in_right_i_left_o_standard(uint32_t ddhold){
    uint32_t count;
    uint32_t holds = ddhold;

    clock11();
    clock11();

    for (count = 0; count < 7; count++) {
	if (holds != 0) {
	    clock11();
	    holds--;
	}
	else
	    clock00();
    }

    clock01();
    clock00();    
    clock10();
    clock11();
}

void clock_in_right_i_left_i_standard(uint32_t ddhold){
    uint32_t count;
    uint32_t holds = ddhold;

    clock11();
    clock11();

    for (count = 0; count < 7; count++) {
	if (holds != 0) {
	    clock11();
	    holds--;
	}
	else
	    clock00();
    }

    clock00();
    clock00();    
    clock11();
    clock11();
}

/* Clock in data on the right side.  Clock the normal13 times,
 * which is correct for no hold violation or for a data-
 * dependent hold violation (for the latter, ddhold must be
 * incremented before calling the subroutine).
 *
 * Right side = GPIOs 0 to18
 */

void clock_in_right_standard(uint32_t ddhold){
    uint32_t count;
    uint32_t holds = ddhold;

    clock11();
    clock11();

    for (count = 0; count < 7; count++) {
	if (holds != 0) {
	    clock01();
	    holds--;
	}
	else
	    clock00();
    }

    clock10();
    clock00();
    clock01();
    clock11();
}

void clock_in_right_i_left_io_standard(uint32_t ddhold){
    uint32_t count;
    uint32_t holds = ddhold;

    clock11();
    clock11();

    for (count = 0; count < 7; count++) {
	if (holds != 0) {
	    clock11();
	    holds--;
	}
	else
	    clock00();
    }

    clock01();
    clock00();    
    clock11();
    clock11();
}
// --------------------------------------------------------
// Clock in data for GPIO 0 and 37 (fixed) and apply load.
// --------------------------------------------------------

void clock_in_end(){
	// Right side:  GPIO 0 configured disabled
	// Left side:  GPIO 37 configured as input
	clock11();
	clock10();
	clock00();
	clock00();
	clock00();
	clock00();
	clock00();
	clock00();
	clock00();
	clock01();
	clock00();
	clock11();
	clock11();

	load();
}

// --------------------------------------------------------
// Same as above, except that GPIO is configured as an
// output for a quick sanity check.
// --------------------------------------------------------

void clock_in_end_output()
{
	// Right side:  GPIO 0 configured disabled
	// Left side:  GPIO 37 configured as output
	clock11();
	clock10();
	clock00();
	clock00();
	clock00();
	clock00();
	clock00();
	clock00();
	clock00();
	clock01();
	clock00();
	clock01();
	clock11();

	load();

	reg_mprj_io_37 = GPIO_MODE_MGMT_STD_OUTPUT;
}
