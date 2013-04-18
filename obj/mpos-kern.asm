
obj/mpos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# MiniprocOS's kernel stack, then jumps to the 'start' routine in mpos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x200000, %esp
  10000c:	bc 00 00 20 00       	mov    $0x200000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 4d 01 00 00       	call   100166 <start>
  100019:	90                   	nop

0010001a <sys_int48_handler>:

# Interrupt handlers
.align 2

sys_int48_handler:
	pushl $0
  10001a:	6a 00                	push   $0x0
	pushl $48
  10001c:	6a 30                	push   $0x30
	jmp _generic_int_handler
  10001e:	eb 3a                	jmp    10005a <_generic_int_handler>

00100020 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $49
  100022:	6a 31                	push   $0x31
	jmp _generic_int_handler
  100024:	eb 34                	jmp    10005a <_generic_int_handler>

00100026 <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $50
  100028:	6a 32                	push   $0x32
	jmp _generic_int_handler
  10002a:	eb 2e                	jmp    10005a <_generic_int_handler>

0010002c <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $51
  10002e:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100030:	eb 28                	jmp    10005a <_generic_int_handler>

00100032 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $52
  100034:	6a 34                	push   $0x34
	jmp _generic_int_handler
  100036:	eb 22                	jmp    10005a <_generic_int_handler>

00100038 <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $53
  10003a:	6a 35                	push   $0x35
	jmp _generic_int_handler
  10003c:	eb 1c                	jmp    10005a <_generic_int_handler>

0010003e <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $54
  100040:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100042:	eb 16                	jmp    10005a <_generic_int_handler>

00100044 <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $55
  100046:	6a 37                	push   $0x37
	jmp _generic_int_handler
  100048:	eb 10                	jmp    10005a <_generic_int_handler>

0010004a <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $56
  10004c:	6a 38                	push   $0x38
	jmp _generic_int_handler
  10004e:	eb 0a                	jmp    10005a <_generic_int_handler>

00100050 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $57
  100052:	6a 39                	push   $0x39
	jmp _generic_int_handler
  100054:	eb 04                	jmp    10005a <_generic_int_handler>

00100056 <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	jmp _generic_int_handler
  100058:	eb 00                	jmp    10005a <_generic_int_handler>

0010005a <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the interrupt number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  10005a:	1e                   	push   %ds
	pushl %es
  10005b:	06                   	push   %es
	pushal
  10005c:	60                   	pusha  

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10005d:	54                   	push   %esp
	call interrupt
  10005e:	e8 58 00 00 00       	call   1000bb <interrupt>

00100063 <sys_int_handlers>:
  100063:	1a 00                	sbb    (%eax),%al
  100065:	10 00                	adc    %al,(%eax)
  100067:	20 00                	and    %al,(%eax)
  100069:	10 00                	adc    %al,(%eax)
  10006b:	26 00 10             	add    %dl,%es:(%eax)
  10006e:	00 2c 00             	add    %ch,(%eax,%eax,1)
  100071:	10 00                	adc    %al,(%eax)
  100073:	32 00                	xor    (%eax),%al
  100075:	10 00                	adc    %al,(%eax)
  100077:	38 00                	cmp    %al,(%eax)
  100079:	10 00                	adc    %al,(%eax)
  10007b:	3e 00 10             	add    %dl,%ds:(%eax)
  10007e:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  100082:	00 4a 00             	add    %cl,0x0(%edx)
  100085:	10 00                	adc    %al,(%eax)
  100087:	50                   	push   %eax
  100088:	00 10                	add    %dl,(%eax)
  10008a:	00 90 83 ec 0c a1    	add    %dl,-0x5ef3137d(%eax)

0010008c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10008c:	83 ec 0c             	sub    $0xc,%esp
	pid_t pid = current->p_pid;
  10008f:	a1 6c 9d 10 00       	mov    0x109d6c,%eax
	while (1) {
		pid = (pid + 1) % NPROCS;
  100094:	b9 10 00 00 00       	mov    $0x10,%ecx
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  100099:	8b 10                	mov    (%eax),%edx
	while (1) {
		pid = (pid + 1) % NPROCS;
  10009b:	8d 42 01             	lea    0x1(%edx),%eax
  10009e:	99                   	cltd   
  10009f:	f7 f9                	idiv   %ecx
		if (proc_array[pid].p_state == P_RUNNABLE)
  1000a1:	6b c2 50             	imul   $0x50,%edx,%eax
  1000a4:	83 b8 4c 90 10 00 01 	cmpl   $0x1,0x10904c(%eax)
  1000ab:	75 ee                	jne    10009b <schedule+0xf>
			run(&proc_array[pid]);
  1000ad:	83 ec 0c             	sub    $0xc,%esp
  1000b0:	05 04 90 10 00       	add    $0x109004,%eax
  1000b5:	50                   	push   %eax
  1000b6:	e8 c5 02 00 00       	call   100380 <run>

001000bb <interrupt>:

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000bb:	57                   	push   %edi
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000bc:	b9 11 00 00 00       	mov    $0x11,%ecx

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000c1:	56                   	push   %esi
  1000c2:	83 ec 04             	sub    $0x4,%esp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000c5:	a1 6c 9d 10 00       	mov    0x109d6c,%eax

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000ca:	8b 54 24 10          	mov    0x10(%esp),%edx
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000ce:	8d 78 04             	lea    0x4(%eax),%edi
  1000d1:	89 d6                	mov    %edx,%esi
  1000d3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1000d5:	8b 52 28             	mov    0x28(%edx),%edx
  1000d8:	83 ea 30             	sub    $0x30,%edx
  1000db:	83 fa 04             	cmp    $0x4,%edx
  1000de:	0f 87 80 00 00 00    	ja     100164 <interrupt+0xa9>
  1000e4:	ff 24 95 3c 09 10 00 	jmp    *0x10093c(,%edx,4)
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000eb:	8b 10                	mov    (%eax),%edx
  1000ed:	89 50 20             	mov    %edx,0x20(%eax)
  1000f0:	eb 07                	jmp    1000f9 <interrupt+0x3e>
		run(current);

	case INT_SYS_FORK:
		// The 'sys_fork' system call should create a new process.
		// You will have to complete the do_fork() function!
		current->p_registers.reg_eax = do_fork(current);
  1000f2:	c7 40 20 ff ff ff ff 	movl   $0xffffffff,0x20(%eax)
		run(current);
  1000f9:	83 ec 0c             	sub    $0xc,%esp
  1000fc:	50                   	push   %eax
  1000fd:	e8 7e 02 00 00       	call   100380 <run>
	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule a
		// different process.  (MiniprocOS is cooperatively
		// scheduled, so we need a special system call to do this.)
		// The schedule() function picks another process and runs it.
		schedule();
  100102:	e8 85 ff ff ff       	call   10008c <schedule>
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
  100107:	a1 6c 9d 10 00       	mov    0x109d6c,%eax
		current->p_exit_status = current->p_registers.reg_eax;
  10010c:	8b 50 20             	mov    0x20(%eax),%edx
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
  10010f:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = current->p_registers.reg_eax;
  100116:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  100119:	e8 6e ff ff ff       	call   10008c <schedule>
		// * A process that doesn't exist (p_state == P_EMPTY).
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
  10011e:	a1 6c 9d 10 00       	mov    0x109d6c,%eax
  100123:	8b 50 20             	mov    0x20(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  100126:	8d 4a ff             	lea    -0x1(%edx),%ecx
  100129:	83 f9 0e             	cmp    $0xe,%ecx
  10012c:	77 11                	ja     10013f <interrupt+0x84>
  10012e:	3b 10                	cmp    (%eax),%edx
  100130:	74 0d                	je     10013f <interrupt+0x84>
		    || proc_array[p].p_state == P_EMPTY)
  100132:	6b d2 50             	imul   $0x50,%edx,%edx
  100135:	8b 8a 4c 90 10 00    	mov    0x10904c(%edx),%ecx
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  10013b:	85 c9                	test   %ecx,%ecx
  10013d:	75 09                	jne    100148 <interrupt+0x8d>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
  10013f:	c7 40 20 ff ff ff ff 	movl   $0xffffffff,0x20(%eax)
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  100146:	eb 17                	jmp    10015f <interrupt+0xa4>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE)
  100148:	83 f9 03             	cmp    $0x3,%ecx
  10014b:	75 0b                	jne    100158 <interrupt+0x9d>
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  10014d:	8b 92 50 90 10 00    	mov    0x109050(%edx),%edx
  100153:	89 50 20             	mov    %edx,0x20(%eax)
  100156:	eb 07                	jmp    10015f <interrupt+0xa4>
		else
			current->p_registers.reg_eax = WAIT_TRYAGAIN;
  100158:	c7 40 20 fe ff ff ff 	movl   $0xfffffffe,0x20(%eax)
		schedule();
  10015f:	e8 28 ff ff ff       	call   10008c <schedule>
  100164:	eb fe                	jmp    100164 <interrupt+0xa9>

00100166 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100166:	53                   	push   %ebx
  100167:	83 ec 0c             	sub    $0xc,%esp
	const char *s;
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10016a:	68 00 05 00 00       	push   $0x500
  10016f:	6a 00                	push   $0x0
  100171:	68 04 90 10 00       	push   $0x109004
  100176:	e8 41 03 00 00       	call   1004bc <memset>
  10017b:	ba 04 90 10 00       	mov    $0x109004,%edx
  100180:	31 c0                	xor    %eax,%eax
  100182:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100185:	89 02                	mov    %eax,(%edx)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100187:	40                   	inc    %eax
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100188:	c7 42 48 00 00 00 00 	movl   $0x0,0x48(%edx)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  10018f:	83 c2 50             	add    $0x50,%edx
  100192:	83 f8 10             	cmp    $0x10,%eax
  100195:	75 ee                	jne    100185 <start+0x1f>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// The first process has process ID 1.
	current = &proc_array[1];
  100197:	c7 05 6c 9d 10 00 54 	movl   $0x109054,0x109d6c
  10019e:	90 10 00 

	// Set up x86 hardware, and initialize the first process's
	// special registers.  This only needs to be done once, at boot time.
	// All other processes' special registers can be copied from the
	// first process.
	segments_init();
  1001a1:	e8 72 00 00 00       	call   100218 <segments_init>
	special_registers_init(current);
  1001a6:	83 ec 0c             	sub    $0xc,%esp
  1001a9:	ff 35 6c 9d 10 00    	pushl  0x109d6c
  1001af:	e8 e3 01 00 00       	call   100397 <special_registers_init>

	// Erase the console, and initialize the cursor-position shared
	// variable to point to its upper left.
	console_clear();
  1001b4:	e8 2e 01 00 00       	call   1002e7 <console_clear>

	// Figure out which program to run.
	cursorpos = console_printf(cursorpos, 0x0700, "Type '1' to run mpos-app, or '2' to run mpos-app2.");
  1001b9:	83 c4 0c             	add    $0xc,%esp
  1001bc:	68 50 09 10 00       	push   $0x100950
  1001c1:	68 00 07 00 00       	push   $0x700
  1001c6:	ff 35 00 00 06 00    	pushl  0x60000
  1001cc:	e8 50 07 00 00       	call   100921 <console_printf>
  1001d1:	83 c4 10             	add    $0x10,%esp
  1001d4:	a3 00 00 06 00       	mov    %eax,0x60000
	do {
		whichprocess = console_read_digit();
  1001d9:	e8 4c 01 00 00       	call   10032a <console_read_digit>
	} while (whichprocess != 1 && whichprocess != 2);
  1001de:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1001e1:	83 fb 01             	cmp    $0x1,%ebx
  1001e4:	77 f3                	ja     1001d9 <start+0x73>
	console_clear();
  1001e6:	e8 fc 00 00 00       	call   1002e7 <console_clear>

	// Load the process application code and data into memory.
	// Store its entry point into the first process's EIP
	// (instruction pointer).
	program_loader(whichprocess - 1, &current->p_registers.reg_eip);
  1001eb:	50                   	push   %eax
  1001ec:	50                   	push   %eax
  1001ed:	a1 6c 9d 10 00       	mov    0x109d6c,%eax
  1001f2:	83 c0 34             	add    $0x34,%eax
  1001f5:	50                   	push   %eax
  1001f6:	53                   	push   %ebx
  1001f7:	e8 d0 01 00 00       	call   1003cc <program_loader>

	// Set the main process's stack pointer, ESP.
	current->p_registers.reg_esp = PROC1_STACK_ADDR + PROC_STACK_SIZE;
  1001fc:	a1 6c 9d 10 00       	mov    0x109d6c,%eax
  100201:	c7 40 40 00 00 2c 00 	movl   $0x2c0000,0x40(%eax)

	// Mark the process as runnable!
	current->p_state = P_RUNNABLE;
  100208:	c7 40 48 01 00 00 00 	movl   $0x1,0x48(%eax)

	// Switch to the main process using run().
	run(current);
  10020f:	89 04 24             	mov    %eax,(%esp)
  100212:	e8 69 01 00 00       	call   100380 <run>
  100217:	90                   	nop

00100218 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100218:	b8 04 95 10 00       	mov    $0x109504,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10021d:	b9 56 00 10 00       	mov    $0x100056,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100222:	89 c2                	mov    %eax,%edx
  100224:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100227:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100228:	bb 56 00 10 00       	mov    $0x100056,%ebx
  10022d:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100230:	66 a3 ee 19 10 00    	mov    %ax,0x1019ee
  100236:	c1 e8 18             	shr    $0x18,%eax
  100239:	88 15 f0 19 10 00    	mov    %dl,0x1019f0
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10023f:	ba 6c 95 10 00       	mov    $0x10956c,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100244:	a2 f3 19 10 00       	mov    %al,0x1019f3
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100249:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10024b:	66 c7 05 ec 19 10 00 	movw   $0x68,0x1019ec
  100252:	68 00 
  100254:	c6 05 f2 19 10 00 40 	movb   $0x40,0x1019f2
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10025b:	c6 05 f1 19 10 00 89 	movb   $0x89,0x1019f1

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100262:	c7 05 08 95 10 00 00 	movl   $0x80000,0x109508
  100269:	00 08 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  10026c:	66 c7 05 0c 95 10 00 	movw   $0x10,0x10950c
  100273:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100275:	66 89 0c c5 6c 95 10 	mov    %cx,0x10956c(,%eax,8)
  10027c:	00 
  10027d:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100284:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100289:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10028e:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100293:	40                   	inc    %eax
  100294:	3d 00 01 00 00       	cmp    $0x100,%eax
  100299:	75 da                	jne    100275 <segments_init+0x5d>
  10029b:	66 b8 30 00          	mov    $0x30,%ax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10029f:	ba 6c 95 10 00       	mov    $0x10956c,%edx
  1002a4:	8b 0c 85 a3 ff 0f 00 	mov    0xfffa3(,%eax,4),%ecx
  1002ab:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1002b2:	66 89 0c c5 6c 95 10 	mov    %cx,0x10956c(,%eax,8)
  1002b9:	00 
  1002ba:	c1 e9 10             	shr    $0x10,%ecx
  1002bd:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1002c2:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1002c7:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
  1002cc:	40                   	inc    %eax
  1002cd:	83 f8 3a             	cmp    $0x3a,%eax
  1002d0:	75 d2                	jne    1002a4 <segments_init+0x8c>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1002d2:	b0 28                	mov    $0x28,%al
  1002d4:	0f 01 15 b4 19 10 00 	lgdtl  0x1019b4
  1002db:	0f 00 d8             	ltr    %ax
  1002de:	0f 01 1d bc 19 10 00 	lidtl  0x1019bc
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1002e5:	5b                   	pop    %ebx
  1002e6:	c3                   	ret    

001002e7 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1002e7:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1002e8:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1002ea:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1002eb:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  1002f2:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1002f5:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  1002fc:	00 20 07 
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1002ff:	40                   	inc    %eax
  100300:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  100305:	75 ee                	jne    1002f5 <console_clear+0xe>
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100307:	be d4 03 00 00       	mov    $0x3d4,%esi
  10030c:	b0 0e                	mov    $0xe,%al
  10030e:	89 f2                	mov    %esi,%edx
  100310:	ee                   	out    %al,(%dx)
  100311:	31 c9                	xor    %ecx,%ecx
  100313:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100318:	88 c8                	mov    %cl,%al
  10031a:	89 da                	mov    %ebx,%edx
  10031c:	ee                   	out    %al,(%dx)
  10031d:	b0 0f                	mov    $0xf,%al
  10031f:	89 f2                	mov    %esi,%edx
  100321:	ee                   	out    %al,(%dx)
  100322:	88 c8                	mov    %cl,%al
  100324:	89 da                	mov    %ebx,%edx
  100326:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100327:	5b                   	pop    %ebx
  100328:	5e                   	pop    %esi
  100329:	c3                   	ret    

0010032a <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10032a:	ba 64 00 00 00       	mov    $0x64,%edx
  10032f:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100330:	a8 01                	test   $0x1,%al
  100332:	74 45                	je     100379 <console_read_digit+0x4f>
  100334:	b2 60                	mov    $0x60,%dl
  100336:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100337:	8d 50 fe             	lea    -0x2(%eax),%edx
  10033a:	80 fa 08             	cmp    $0x8,%dl
  10033d:	77 05                	ja     100344 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10033f:	0f b6 c0             	movzbl %al,%eax
  100342:	48                   	dec    %eax
  100343:	c3                   	ret    
	else if (data == 0x0B)
  100344:	3c 0b                	cmp    $0xb,%al
  100346:	74 35                	je     10037d <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100348:	8d 50 b9             	lea    -0x47(%eax),%edx
  10034b:	80 fa 02             	cmp    $0x2,%dl
  10034e:	77 07                	ja     100357 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100350:	0f b6 c0             	movzbl %al,%eax
  100353:	83 e8 40             	sub    $0x40,%eax
  100356:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100357:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10035a:	80 fa 02             	cmp    $0x2,%dl
  10035d:	77 07                	ja     100366 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10035f:	0f b6 c0             	movzbl %al,%eax
  100362:	83 e8 47             	sub    $0x47,%eax
  100365:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100366:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100369:	80 fa 02             	cmp    $0x2,%dl
  10036c:	77 07                	ja     100375 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10036e:	0f b6 c0             	movzbl %al,%eax
  100371:	83 e8 4e             	sub    $0x4e,%eax
  100374:	c3                   	ret    
	else if (data == 0x53)
  100375:	3c 53                	cmp    $0x53,%al
  100377:	74 04                	je     10037d <console_read_digit+0x53>
  100379:	83 c8 ff             	or     $0xffffffff,%eax
  10037c:	c3                   	ret    
  10037d:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10037f:	c3                   	ret    

00100380 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100380:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100384:	a3 6c 9d 10 00       	mov    %eax,0x109d6c

	asm volatile("movl %0,%%esp\n\t"
  100389:	83 c0 04             	add    $0x4,%eax
  10038c:	89 c4                	mov    %eax,%esp
  10038e:	61                   	popa   
  10038f:	07                   	pop    %es
  100390:	1f                   	pop    %ds
  100391:	83 c4 08             	add    $0x8,%esp
  100394:	cf                   	iret   
  100395:	eb fe                	jmp    100395 <run+0x15>

00100397 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100397:	53                   	push   %ebx
  100398:	83 ec 0c             	sub    $0xc,%esp
  10039b:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10039f:	6a 44                	push   $0x44
  1003a1:	6a 00                	push   $0x0
  1003a3:	8d 43 04             	lea    0x4(%ebx),%eax
  1003a6:	50                   	push   %eax
  1003a7:	e8 10 01 00 00       	call   1004bc <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1003ac:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1003b2:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1003b8:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1003be:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
}
  1003c4:	83 c4 18             	add    $0x18,%esp
  1003c7:	5b                   	pop    %ebx
  1003c8:	c3                   	ret    
  1003c9:	90                   	nop
  1003ca:	90                   	nop
  1003cb:	90                   	nop

001003cc <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1003cc:	55                   	push   %ebp
  1003cd:	57                   	push   %edi
  1003ce:	56                   	push   %esi
  1003cf:	53                   	push   %ebx
  1003d0:	83 ec 1c             	sub    $0x1c,%esp
  1003d3:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1003d7:	83 f8 01             	cmp    $0x1,%eax
  1003da:	7f 04                	jg     1003e0 <program_loader+0x14>
  1003dc:	85 c0                	test   %eax,%eax
  1003de:	79 02                	jns    1003e2 <program_loader+0x16>
  1003e0:	eb fe                	jmp    1003e0 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1003e2:	8b 34 c5 f4 19 10 00 	mov    0x1019f4(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1003e9:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1003ef:	74 02                	je     1003f3 <program_loader+0x27>
  1003f1:	eb fe                	jmp    1003f1 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1003f3:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1003f6:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1003fa:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1003fc:	c1 e5 05             	shl    $0x5,%ebp
  1003ff:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100402:	eb 3f                	jmp    100443 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100404:	83 3b 01             	cmpl   $0x1,(%ebx)
  100407:	75 37                	jne    100440 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100409:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10040c:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10040f:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100412:	01 c7                	add    %eax,%edi
	memsz += va;
  100414:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100416:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10041b:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10041f:	52                   	push   %edx
  100420:	89 fa                	mov    %edi,%edx
  100422:	29 c2                	sub    %eax,%edx
  100424:	52                   	push   %edx
  100425:	8b 53 04             	mov    0x4(%ebx),%edx
  100428:	01 f2                	add    %esi,%edx
  10042a:	52                   	push   %edx
  10042b:	50                   	push   %eax
  10042c:	e8 27 00 00 00       	call   100458 <memcpy>
  100431:	83 c4 10             	add    $0x10,%esp
  100434:	eb 04                	jmp    10043a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100436:	c6 07 00             	movb   $0x0,(%edi)
  100439:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10043a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10043e:	72 f6                	jb     100436 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100440:	83 c3 20             	add    $0x20,%ebx
  100443:	39 eb                	cmp    %ebp,%ebx
  100445:	72 bd                	jb     100404 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100447:	8b 56 18             	mov    0x18(%esi),%edx
  10044a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10044e:	89 10                	mov    %edx,(%eax)
}
  100450:	83 c4 1c             	add    $0x1c,%esp
  100453:	5b                   	pop    %ebx
  100454:	5e                   	pop    %esi
  100455:	5f                   	pop    %edi
  100456:	5d                   	pop    %ebp
  100457:	c3                   	ret    

00100458 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100458:	56                   	push   %esi
  100459:	31 d2                	xor    %edx,%edx
  10045b:	53                   	push   %ebx
  10045c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100460:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100464:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100468:	eb 08                	jmp    100472 <memcpy+0x1a>
		*d++ = *s++;
  10046a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10046d:	4e                   	dec    %esi
  10046e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100471:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100472:	85 f6                	test   %esi,%esi
  100474:	75 f4                	jne    10046a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100476:	5b                   	pop    %ebx
  100477:	5e                   	pop    %esi
  100478:	c3                   	ret    

00100479 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100479:	57                   	push   %edi
  10047a:	56                   	push   %esi
  10047b:	53                   	push   %ebx
  10047c:	8b 44 24 10          	mov    0x10(%esp),%eax
  100480:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100484:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100488:	39 c7                	cmp    %eax,%edi
  10048a:	73 26                	jae    1004b2 <memmove+0x39>
  10048c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10048f:	39 c6                	cmp    %eax,%esi
  100491:	76 1f                	jbe    1004b2 <memmove+0x39>
		s += n, d += n;
  100493:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100496:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100498:	eb 07                	jmp    1004a1 <memmove+0x28>
			*--d = *--s;
  10049a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  10049d:	4a                   	dec    %edx
  10049e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1004a1:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1004a2:	85 d2                	test   %edx,%edx
  1004a4:	75 f4                	jne    10049a <memmove+0x21>
  1004a6:	eb 10                	jmp    1004b8 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1004a8:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1004ab:	4a                   	dec    %edx
  1004ac:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1004af:	41                   	inc    %ecx
  1004b0:	eb 02                	jmp    1004b4 <memmove+0x3b>
  1004b2:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1004b4:	85 d2                	test   %edx,%edx
  1004b6:	75 f0                	jne    1004a8 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1004b8:	5b                   	pop    %ebx
  1004b9:	5e                   	pop    %esi
  1004ba:	5f                   	pop    %edi
  1004bb:	c3                   	ret    

001004bc <memset>:

void *
memset(void *v, int c, size_t n)
{
  1004bc:	53                   	push   %ebx
  1004bd:	8b 44 24 08          	mov    0x8(%esp),%eax
  1004c1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1004c5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1004c9:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1004cb:	eb 04                	jmp    1004d1 <memset+0x15>
		*p++ = c;
  1004cd:	88 1a                	mov    %bl,(%edx)
  1004cf:	49                   	dec    %ecx
  1004d0:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1004d1:	85 c9                	test   %ecx,%ecx
  1004d3:	75 f8                	jne    1004cd <memset+0x11>
		*p++ = c;
	return v;
}
  1004d5:	5b                   	pop    %ebx
  1004d6:	c3                   	ret    

001004d7 <strlen>:

size_t
strlen(const char *s)
{
  1004d7:	8b 54 24 04          	mov    0x4(%esp),%edx
  1004db:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1004dd:	eb 01                	jmp    1004e0 <strlen+0x9>
		++n;
  1004df:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1004e0:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1004e4:	75 f9                	jne    1004df <strlen+0x8>
		++n;
	return n;
}
  1004e6:	c3                   	ret    

001004e7 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1004e7:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1004eb:	31 c0                	xor    %eax,%eax
  1004ed:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1004f1:	eb 01                	jmp    1004f4 <strnlen+0xd>
		++n;
  1004f3:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1004f4:	39 d0                	cmp    %edx,%eax
  1004f6:	74 06                	je     1004fe <strnlen+0x17>
  1004f8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1004fc:	75 f5                	jne    1004f3 <strnlen+0xc>
		++n;
	return n;
}
  1004fe:	c3                   	ret    

001004ff <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1004ff:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100500:	3d a0 8f 0b 00       	cmp    $0xb8fa0,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100505:	53                   	push   %ebx
  100506:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100508:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  10050d:	0f 43 d8             	cmovae %eax,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100510:	80 fa 0a             	cmp    $0xa,%dl
  100513:	75 2c                	jne    100541 <console_putc+0x42>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100515:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10051b:	be 50 00 00 00       	mov    $0x50,%esi
  100520:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100522:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100525:	99                   	cltd   
  100526:	f7 fe                	idiv   %esi
  100528:	89 de                	mov    %ebx,%esi
  10052a:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10052c:	eb 07                	jmp    100535 <console_putc+0x36>
			*cursor++ = ' ' | color;
  10052e:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100531:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100532:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100535:	83 f8 50             	cmp    $0x50,%eax
  100538:	75 f4                	jne    10052e <console_putc+0x2f>
  10053a:	29 d0                	sub    %edx,%eax
  10053c:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10053f:	eb 0b                	jmp    10054c <console_putc+0x4d>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100541:	0f b6 d2             	movzbl %dl,%edx
  100544:	09 ca                	or     %ecx,%edx
  100546:	66 89 13             	mov    %dx,(%ebx)
  100549:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10054c:	5b                   	pop    %ebx
  10054d:	5e                   	pop    %esi
  10054e:	c3                   	ret    

0010054f <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10054f:	56                   	push   %esi
  100550:	53                   	push   %ebx
  100551:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100555:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100558:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10055c:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100561:	75 04                	jne    100567 <fill_numbuf+0x18>
  100563:	85 d2                	test   %edx,%edx
  100565:	74 10                	je     100577 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100567:	89 d0                	mov    %edx,%eax
  100569:	31 d2                	xor    %edx,%edx
  10056b:	f7 f1                	div    %ecx
  10056d:	4b                   	dec    %ebx
  10056e:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100571:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100573:	89 c2                	mov    %eax,%edx
  100575:	eb ec                	jmp    100563 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100577:	89 d8                	mov    %ebx,%eax
  100579:	5b                   	pop    %ebx
  10057a:	5e                   	pop    %esi
  10057b:	c3                   	ret    

0010057c <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10057c:	55                   	push   %ebp
  10057d:	57                   	push   %edi
  10057e:	56                   	push   %esi
  10057f:	53                   	push   %ebx
  100580:	83 ec 38             	sub    $0x38,%esp
  100583:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100587:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10058b:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10058f:	e9 62 03 00 00       	jmp    1008f6 <console_vprintf+0x37a>
		if (*format != '%') {
  100594:	80 fa 25             	cmp    $0x25,%dl
  100597:	74 13                	je     1005ac <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100599:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10059d:	0f b6 d2             	movzbl %dl,%edx
  1005a0:	89 f0                	mov    %esi,%eax
  1005a2:	e8 58 ff ff ff       	call   1004ff <console_putc>
  1005a7:	e9 47 03 00 00       	jmp    1008f3 <console_vprintf+0x377>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1005ac:	47                   	inc    %edi
  1005ad:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1005b4:	00 
  1005b5:	eb 12                	jmp    1005c9 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1005b7:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1005b8:	8a 11                	mov    (%ecx),%dl
  1005ba:	84 d2                	test   %dl,%dl
  1005bc:	74 1a                	je     1005d8 <console_vprintf+0x5c>
  1005be:	89 e8                	mov    %ebp,%eax
  1005c0:	38 c2                	cmp    %al,%dl
  1005c2:	75 f3                	jne    1005b7 <console_vprintf+0x3b>
  1005c4:	e9 41 03 00 00       	jmp    10090a <console_vprintf+0x38e>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1005c9:	8a 17                	mov    (%edi),%dl
  1005cb:	84 d2                	test   %dl,%dl
  1005cd:	74 0b                	je     1005da <console_vprintf+0x5e>
  1005cf:	b9 84 09 10 00       	mov    $0x100984,%ecx
  1005d4:	89 d5                	mov    %edx,%ebp
  1005d6:	eb e0                	jmp    1005b8 <console_vprintf+0x3c>
  1005d8:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1005da:	8d 42 cf             	lea    -0x31(%edx),%eax
  1005dd:	3c 08                	cmp    $0x8,%al
  1005df:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1005e6:	00 
  1005e7:	76 13                	jbe    1005fc <console_vprintf+0x80>
  1005e9:	eb 1d                	jmp    100608 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1005eb:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1005f0:	0f be c0             	movsbl %al,%eax
  1005f3:	47                   	inc    %edi
  1005f4:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1005f8:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1005fc:	8a 07                	mov    (%edi),%al
  1005fe:	8d 50 d0             	lea    -0x30(%eax),%edx
  100601:	80 fa 09             	cmp    $0x9,%dl
  100604:	76 e5                	jbe    1005eb <console_vprintf+0x6f>
  100606:	eb 18                	jmp    100620 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100608:	80 fa 2a             	cmp    $0x2a,%dl
  10060b:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100612:	ff 
  100613:	75 0b                	jne    100620 <console_vprintf+0xa4>
			width = va_arg(val, int);
  100615:	83 c3 04             	add    $0x4,%ebx
			++format;
  100618:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100619:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10061c:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100620:	83 cd ff             	or     $0xffffffff,%ebp
  100623:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100626:	75 37                	jne    10065f <console_vprintf+0xe3>
			++format;
  100628:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100629:	31 ed                	xor    %ebp,%ebp
  10062b:	8a 07                	mov    (%edi),%al
  10062d:	8d 50 d0             	lea    -0x30(%eax),%edx
  100630:	80 fa 09             	cmp    $0x9,%dl
  100633:	76 0d                	jbe    100642 <console_vprintf+0xc6>
  100635:	eb 17                	jmp    10064e <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100637:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  10063a:	0f be c0             	movsbl %al,%eax
  10063d:	47                   	inc    %edi
  10063e:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100642:	8a 07                	mov    (%edi),%al
  100644:	8d 50 d0             	lea    -0x30(%eax),%edx
  100647:	80 fa 09             	cmp    $0x9,%dl
  10064a:	76 eb                	jbe    100637 <console_vprintf+0xbb>
  10064c:	eb 11                	jmp    10065f <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10064e:	3c 2a                	cmp    $0x2a,%al
  100650:	75 0b                	jne    10065d <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100652:	83 c3 04             	add    $0x4,%ebx
				++format;
  100655:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100656:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100659:	85 ed                	test   %ebp,%ebp
  10065b:	79 02                	jns    10065f <console_vprintf+0xe3>
  10065d:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10065f:	8a 07                	mov    (%edi),%al
  100661:	3c 64                	cmp    $0x64,%al
  100663:	74 34                	je     100699 <console_vprintf+0x11d>
  100665:	7f 1d                	jg     100684 <console_vprintf+0x108>
  100667:	3c 58                	cmp    $0x58,%al
  100669:	0f 84 a2 00 00 00    	je     100711 <console_vprintf+0x195>
  10066f:	3c 63                	cmp    $0x63,%al
  100671:	0f 84 bf 00 00 00    	je     100736 <console_vprintf+0x1ba>
  100677:	3c 43                	cmp    $0x43,%al
  100679:	0f 85 d0 00 00 00    	jne    10074f <console_vprintf+0x1d3>
  10067f:	e9 a3 00 00 00       	jmp    100727 <console_vprintf+0x1ab>
  100684:	3c 75                	cmp    $0x75,%al
  100686:	74 4d                	je     1006d5 <console_vprintf+0x159>
  100688:	3c 78                	cmp    $0x78,%al
  10068a:	74 5c                	je     1006e8 <console_vprintf+0x16c>
  10068c:	3c 73                	cmp    $0x73,%al
  10068e:	0f 85 bb 00 00 00    	jne    10074f <console_vprintf+0x1d3>
  100694:	e9 86 00 00 00       	jmp    10071f <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100699:	83 c3 04             	add    $0x4,%ebx
  10069c:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10069f:	89 d1                	mov    %edx,%ecx
  1006a1:	c1 f9 1f             	sar    $0x1f,%ecx
  1006a4:	89 0c 24             	mov    %ecx,(%esp)
  1006a7:	31 ca                	xor    %ecx,%edx
  1006a9:	55                   	push   %ebp
  1006aa:	29 ca                	sub    %ecx,%edx
  1006ac:	68 8c 09 10 00       	push   $0x10098c
  1006b1:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1006b6:	8d 44 24 40          	lea    0x40(%esp),%eax
  1006ba:	e8 90 fe ff ff       	call   10054f <fill_numbuf>
  1006bf:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1006c3:	58                   	pop    %eax
  1006c4:	5a                   	pop    %edx
  1006c5:	ba 01 00 00 00       	mov    $0x1,%edx
  1006ca:	8b 04 24             	mov    (%esp),%eax
  1006cd:	83 e0 01             	and    $0x1,%eax
  1006d0:	e9 a6 00 00 00       	jmp    10077b <console_vprintf+0x1ff>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1006d5:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1006d8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1006dd:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1006e0:	55                   	push   %ebp
  1006e1:	68 8c 09 10 00       	push   $0x10098c
  1006e6:	eb 11                	jmp    1006f9 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1006e8:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1006eb:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1006ee:	55                   	push   %ebp
  1006ef:	68 a0 09 10 00       	push   $0x1009a0
  1006f4:	b9 10 00 00 00       	mov    $0x10,%ecx
  1006f9:	8d 44 24 40          	lea    0x40(%esp),%eax
  1006fd:	e8 4d fe ff ff       	call   10054f <fill_numbuf>
  100702:	ba 01 00 00 00       	mov    $0x1,%edx
  100707:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10070b:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  10070d:	59                   	pop    %ecx
  10070e:	59                   	pop    %ecx
  10070f:	eb 6a                	jmp    10077b <console_vprintf+0x1ff>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100711:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100714:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100717:	55                   	push   %ebp
  100718:	68 8c 09 10 00       	push   $0x10098c
  10071d:	eb d5                	jmp    1006f4 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10071f:	83 c3 04             	add    $0x4,%ebx
  100722:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100725:	eb 41                	jmp    100768 <console_vprintf+0x1ec>
			break;
		case 'C':
			color = va_arg(val, int);
  100727:	83 c3 04             	add    $0x4,%ebx
  10072a:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10072d:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100731:	e9 bf 01 00 00       	jmp    1008f5 <console_vprintf+0x379>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100736:	83 c3 04             	add    $0x4,%ebx
  100739:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10073c:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100740:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100745:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100749:	88 44 24 24          	mov    %al,0x24(%esp)
  10074d:	eb 28                	jmp    100777 <console_vprintf+0x1fb>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10074f:	84 c0                	test   %al,%al
  100751:	b2 25                	mov    $0x25,%dl
  100753:	0f 44 c2             	cmove  %edx,%eax
  100756:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  10075a:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10075f:	80 3f 00             	cmpb   $0x0,(%edi)
  100762:	74 0a                	je     10076e <console_vprintf+0x1f2>
  100764:	8d 44 24 24          	lea    0x24(%esp),%eax
  100768:	89 44 24 04          	mov    %eax,0x4(%esp)
  10076c:	eb 09                	jmp    100777 <console_vprintf+0x1fb>
				format--;
  10076e:	8d 54 24 24          	lea    0x24(%esp),%edx
  100772:	4f                   	dec    %edi
  100773:	89 54 24 04          	mov    %edx,0x4(%esp)
  100777:	31 d2                	xor    %edx,%edx
  100779:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10077b:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10077d:	83 fd ff             	cmp    $0xffffffff,%ebp
  100780:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100787:	74 1f                	je     1007a8 <console_vprintf+0x22c>
  100789:	89 04 24             	mov    %eax,(%esp)
  10078c:	eb 01                	jmp    10078f <console_vprintf+0x213>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  10078e:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10078f:	39 e9                	cmp    %ebp,%ecx
  100791:	74 0a                	je     10079d <console_vprintf+0x221>
  100793:	8b 44 24 04          	mov    0x4(%esp),%eax
  100797:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  10079b:	75 f1                	jne    10078e <console_vprintf+0x212>
  10079d:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1007a0:	89 0c 24             	mov    %ecx,(%esp)
  1007a3:	eb 1f                	jmp    1007c4 <console_vprintf+0x248>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1007a5:	42                   	inc    %edx
  1007a6:	eb 09                	jmp    1007b1 <console_vprintf+0x235>
  1007a8:	89 d1                	mov    %edx,%ecx
  1007aa:	8b 14 24             	mov    (%esp),%edx
  1007ad:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007b1:	8b 44 24 04          	mov    0x4(%esp),%eax
  1007b5:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1007b9:	75 ea                	jne    1007a5 <console_vprintf+0x229>
  1007bb:	8b 44 24 08          	mov    0x8(%esp),%eax
  1007bf:	89 14 24             	mov    %edx,(%esp)
  1007c2:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1007c4:	85 c0                	test   %eax,%eax
  1007c6:	74 0c                	je     1007d4 <console_vprintf+0x258>
  1007c8:	84 d2                	test   %dl,%dl
  1007ca:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1007d1:	00 
  1007d2:	75 24                	jne    1007f8 <console_vprintf+0x27c>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1007d4:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1007d9:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1007e0:	00 
  1007e1:	75 15                	jne    1007f8 <console_vprintf+0x27c>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1007e3:	8b 44 24 14          	mov    0x14(%esp),%eax
  1007e7:	83 e0 08             	and    $0x8,%eax
  1007ea:	83 f8 01             	cmp    $0x1,%eax
  1007ed:	19 c9                	sbb    %ecx,%ecx
  1007ef:	f7 d1                	not    %ecx
  1007f1:	83 e1 20             	and    $0x20,%ecx
  1007f4:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1007f8:	3b 2c 24             	cmp    (%esp),%ebp
  1007fb:	7e 0d                	jle    10080a <console_vprintf+0x28e>
  1007fd:	84 d2                	test   %dl,%dl
  1007ff:	74 41                	je     100842 <console_vprintf+0x2c6>
			zeros = precision - len;
  100801:	2b 2c 24             	sub    (%esp),%ebp
  100804:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100808:	eb 40                	jmp    10084a <console_vprintf+0x2ce>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10080a:	84 d2                	test   %dl,%dl
  10080c:	74 34                	je     100842 <console_vprintf+0x2c6>
  10080e:	8b 44 24 14          	mov    0x14(%esp),%eax
  100812:	83 e0 06             	and    $0x6,%eax
  100815:	83 f8 02             	cmp    $0x2,%eax
  100818:	75 28                	jne    100842 <console_vprintf+0x2c6>
  10081a:	45                   	inc    %ebp
  10081b:	75 25                	jne    100842 <console_vprintf+0x2c6>
			 && numeric && precision < 0
			 && len + !!negative < width)
  10081d:	31 c0                	xor    %eax,%eax
  10081f:	8b 14 24             	mov    (%esp),%edx
  100822:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100827:	0f 95 c0             	setne  %al
  10082a:	8d 14 10             	lea    (%eax,%edx,1),%edx
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10082d:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100831:	7d 0f                	jge    100842 <console_vprintf+0x2c6>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100833:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100837:	2b 14 24             	sub    (%esp),%edx
  10083a:	29 c2                	sub    %eax,%edx
  10083c:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100840:	eb 08                	jmp    10084a <console_vprintf+0x2ce>
  100842:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100849:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10084a:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  10084e:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100850:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100854:	2b 2c 24             	sub    (%esp),%ebp
  100857:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  10085c:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10085f:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100862:	29 c5                	sub    %eax,%ebp
  100864:	89 f0                	mov    %esi,%eax
  100866:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10086a:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  10086e:	eb 0f                	jmp    10087f <console_vprintf+0x303>
			cursor = console_putc(cursor, ' ', color);
  100870:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100874:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100879:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  10087a:	e8 80 fc ff ff       	call   1004ff <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10087f:	85 ed                	test   %ebp,%ebp
  100881:	7e 07                	jle    10088a <console_vprintf+0x30e>
  100883:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100888:	74 e6                	je     100870 <console_vprintf+0x2f4>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  10088a:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  10088f:	89 c6                	mov    %eax,%esi
  100891:	74 23                	je     1008b6 <console_vprintf+0x33a>
			cursor = console_putc(cursor, negative, color);
  100893:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100898:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10089c:	e8 5e fc ff ff       	call   1004ff <console_putc>
  1008a1:	89 c6                	mov    %eax,%esi
  1008a3:	eb 11                	jmp    1008b6 <console_vprintf+0x33a>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1008a5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1008a9:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1008ae:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  1008af:	e8 4b fc ff ff       	call   1004ff <console_putc>
  1008b4:	eb 06                	jmp    1008bc <console_vprintf+0x340>
  1008b6:	89 f0                	mov    %esi,%eax
  1008b8:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1008bc:	85 f6                	test   %esi,%esi
  1008be:	7f e5                	jg     1008a5 <console_vprintf+0x329>
  1008c0:	8b 34 24             	mov    (%esp),%esi
  1008c3:	eb 15                	jmp    1008da <console_vprintf+0x35e>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  1008c5:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1008c9:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  1008ca:	0f b6 11             	movzbl (%ecx),%edx
  1008cd:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1008d1:	e8 29 fc ff ff       	call   1004ff <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1008d6:	ff 44 24 04          	incl   0x4(%esp)
  1008da:	85 f6                	test   %esi,%esi
  1008dc:	7f e7                	jg     1008c5 <console_vprintf+0x349>
  1008de:	eb 0f                	jmp    1008ef <console_vprintf+0x373>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  1008e0:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1008e4:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1008e9:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1008ea:	e8 10 fc ff ff       	call   1004ff <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1008ef:	85 ed                	test   %ebp,%ebp
  1008f1:	7f ed                	jg     1008e0 <console_vprintf+0x364>
  1008f3:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1008f5:	47                   	inc    %edi
  1008f6:	8a 17                	mov    (%edi),%dl
  1008f8:	84 d2                	test   %dl,%dl
  1008fa:	0f 85 94 fc ff ff    	jne    100594 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100900:	83 c4 38             	add    $0x38,%esp
  100903:	89 f0                	mov    %esi,%eax
  100905:	5b                   	pop    %ebx
  100906:	5e                   	pop    %esi
  100907:	5f                   	pop    %edi
  100908:	5d                   	pop    %ebp
  100909:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  10090a:	81 e9 84 09 10 00    	sub    $0x100984,%ecx
  100910:	b8 01 00 00 00       	mov    $0x1,%eax
  100915:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100917:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100918:	09 44 24 14          	or     %eax,0x14(%esp)
  10091c:	e9 a8 fc ff ff       	jmp    1005c9 <console_vprintf+0x4d>

00100921 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100921:	8d 44 24 10          	lea    0x10(%esp),%eax
  100925:	50                   	push   %eax
  100926:	ff 74 24 10          	pushl  0x10(%esp)
  10092a:	ff 74 24 10          	pushl  0x10(%esp)
  10092e:	ff 74 24 10          	pushl  0x10(%esp)
  100932:	e8 45 fc ff ff       	call   10057c <console_vprintf>
  100937:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  10093a:	c3                   	ret    
