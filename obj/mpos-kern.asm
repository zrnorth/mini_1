
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
  100014:	e8 ee 01 00 00       	call   100207 <start>
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
  10008f:	a1 78 9e 10 00       	mov    0x109e78,%eax
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
  1000a1:	6b c2 54             	imul   $0x54,%edx,%eax
  1000a4:	83 b8 18 91 10 00 01 	cmpl   $0x1,0x109118(%eax)
  1000ab:	75 ee                	jne    10009b <schedule+0xf>
			run(&proc_array[pid]);
  1000ad:	83 ec 0c             	sub    $0xc,%esp
  1000b0:	05 d0 90 10 00       	add    $0x1090d0,%eax
  1000b5:	50                   	push   %eax
  1000b6:	e8 65 03 00 00       	call   100420 <run>

001000bb <interrupt>:

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000bb:	55                   	push   %ebp
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
  1000c1:	57                   	push   %edi
  1000c2:	56                   	push   %esi
  1000c3:	53                   	push   %ebx
  1000c4:	83 ec 1c             	sub    $0x1c,%esp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000c7:	8b 1d 78 9e 10 00    	mov    0x109e78,%ebx

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000cd:	8b 44 24 30          	mov    0x30(%esp),%eax
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000d1:	8d 7b 04             	lea    0x4(%ebx),%edi
  1000d4:	89 c6                	mov    %eax,%esi
  1000d6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1000d8:	8b 40 28             	mov    0x28(%eax),%eax
  1000db:	83 e8 30             	sub    $0x30,%eax
  1000de:	83 f8 04             	cmp    $0x4,%eax
  1000e1:	0f 87 1e 01 00 00    	ja     100205 <interrupt+0x14a>
  1000e7:	ff 24 85 dc 09 10 00 	jmp    *0x1009dc(,%eax,4)
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000ee:	8b 03                	mov    (%ebx),%eax
		run(current);
  1000f0:	83 ec 0c             	sub    $0xc,%esp
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000f3:	89 43 20             	mov    %eax,0x20(%ebx)
		run(current);
  1000f6:	53                   	push   %ebx
  1000f7:	eb 7f                	jmp    100178 <interrupt+0xbd>
  1000f9:	b8 6c 91 10 00       	mov    $0x10916c,%eax
  1000fe:	ba 01 00 00 00       	mov    $0x1,%edx
    int i;
    process_t* child;
    for (i = 1; ; i++) {
        if (i >= NPROCS) return -1; //reached the end of the array.

        if (proc_array[i].p_state == P_EMPTY) { //found an empty pid
  100103:	83 38 00             	cmpl   $0x0,(%eax)
  100106:	75 58                	jne    100160 <interrupt+0xa5>
            child = &proc_array[i];
  100108:	6b c2 54             	imul   $0x54,%edx,%eax
	//                What should sys_fork() return to the child process?)
	// You need to set one other process descriptor field as well.
	// Finally, return the child's process ID to the parent.
    
    //Copy the registers to the child proc
    child->p_registers = parent->p_registers;
  10010b:	b9 11 00 00 00       	mov    $0x11,%ecx
  100110:	8d 73 04             	lea    0x4(%ebx),%esi
    process_t* child;
    for (i = 1; ; i++) {
        if (i >= NPROCS) return -1; //reached the end of the array.

        if (proc_array[i].p_state == P_EMPTY) { //found an empty pid
            child = &proc_array[i];
  100113:	8d a8 d0 90 10 00    	lea    0x1090d0(%eax),%ebp
	//                What should sys_fork() return to the child process?)
	// You need to set one other process descriptor field as well.
	// Finally, return the child's process ID to the parent.
    
    //Copy the registers to the child proc
    child->p_registers = parent->p_registers;
  100119:	8d 7d 04             	lea    0x4(%ebp),%edi
  10011c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	// YOUR CODE HERE!
	src_stack_top = PROC1_STACK_ADDR + ((src->p_pid) * PROC_STACK_SIZE);
	src_stack_bottom = src->p_registers.reg_esp;
    //Calculate the size of this stack (amt of mem used)
    uint32_t stack_size = src_stack_top - src_stack_bottom;
  10011e:	8b 0b                	mov    (%ebx),%ecx

	dest_stack_top = PROC1_STACK_ADDR + ((dest->p_pid) * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - stack_size; //same size as src
  100120:	8b b0 d0 90 10 00    	mov    0x1090d0(%eax),%esi
    
    //Copy the registers to the child proc
    child->p_registers = parent->p_registers;
    //We can't return to the child directly, so we just set eax to 0
    //When it does get run again, eax will be 0 so it will be like we returned it
    child->p_registers.reg_eax = 0;
  100126:	c7 45 20 00 00 00 00 	movl   $0x0,0x20(%ebp)
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.

	// YOUR CODE HERE!
	src_stack_top = PROC1_STACK_ADDR + ((src->p_pid) * PROC_STACK_SIZE);
	src_stack_bottom = src->p_registers.reg_esp;
  10012d:	8b 7b 40             	mov    0x40(%ebx),%edi
    //Calculate the size of this stack (amt of mem used)
    uint32_t stack_size = src_stack_top - src_stack_bottom;
  100130:	83 c1 0a             	add    $0xa,%ecx
  100133:	c1 e1 12             	shl    $0x12,%ecx

	dest_stack_top = PROC1_STACK_ADDR + ((dest->p_pid) * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - stack_size; //same size as src
  100136:	83 c6 0a             	add    $0xa,%esi

    //copy over the stack
    memcpy((void*)dest_stack_bottom, (void*)src_stack_bottom, stack_size);
  100139:	50                   	push   %eax

	// YOUR CODE HERE!
	src_stack_top = PROC1_STACK_ADDR + ((src->p_pid) * PROC_STACK_SIZE);
	src_stack_bottom = src->p_registers.reg_esp;
    //Calculate the size of this stack (amt of mem used)
    uint32_t stack_size = src_stack_top - src_stack_bottom;
  10013a:	29 f9                	sub    %edi,%ecx

	dest_stack_top = PROC1_STACK_ADDR + ((dest->p_pid) * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - stack_size; //same size as src

    //copy over the stack
    memcpy((void*)dest_stack_bottom, (void*)src_stack_bottom, stack_size);
  10013c:	51                   	push   %ecx
	src_stack_bottom = src->p_registers.reg_esp;
    //Calculate the size of this stack (amt of mem used)
    uint32_t stack_size = src_stack_top - src_stack_bottom;

	dest_stack_top = PROC1_STACK_ADDR + ((dest->p_pid) * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - stack_size; //same size as src
  10013d:	c1 e6 12             	shl    $0x12,%esi

    //copy over the stack
    memcpy((void*)dest_stack_bottom, (void*)src_stack_bottom, stack_size);
  100140:	57                   	push   %edi
	src_stack_bottom = src->p_registers.reg_esp;
    //Calculate the size of this stack (amt of mem used)
    uint32_t stack_size = src_stack_top - src_stack_bottom;

	dest_stack_top = PROC1_STACK_ADDR + ((dest->p_pid) * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - stack_size; //same size as src
  100141:	29 ce                	sub    %ecx,%esi

    //copy over the stack
    memcpy((void*)dest_stack_bottom, (void*)src_stack_bottom, stack_size);
  100143:	56                   	push   %esi
  100144:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  100148:	e8 ab 03 00 00       	call   1004f8 <memcpy>
    //When it does get run again, eax will be 0 so it will be like we returned it
    child->p_registers.reg_eax = 0;
    //Copy the stack to child proc
    copy_stack(child, parent);
    //Make sure the child is set as "runnable."
    child->p_state = P_RUNNABLE;
  10014d:	83 c4 10             	add    $0x10,%esp

    //copy over the stack
    memcpy((void*)dest_stack_bottom, (void*)src_stack_bottom, stack_size);

    //change the esp of the dest to point to new value
    dest->p_registers.reg_esp = dest_stack_bottom;
  100150:	89 75 40             	mov    %esi,0x40(%ebp)
  100153:	8b 54 24 0c          	mov    0xc(%esp),%edx
    //When it does get run again, eax will be 0 so it will be like we returned it
    child->p_registers.reg_eax = 0;
    //Copy the stack to child proc
    copy_stack(child, parent);
    //Make sure the child is set as "runnable."
    child->p_state = P_RUNNABLE;
  100157:	c7 45 48 01 00 00 00 	movl   $0x1,0x48(%ebp)
  10015e:	eb 0c                	jmp    10016c <interrupt+0xb1>
	// First, find an empty process descriptor.  If there is no empty
	//   process descriptor, return -1.  Remember not to use proc_array[0].
    
    int i;
    process_t* child;
    for (i = 1; ; i++) {
  100160:	42                   	inc    %edx
  100161:	83 c0 54             	add    $0x54,%eax
        if (i >= NPROCS) return -1; //reached the end of the array.
  100164:	83 fa 10             	cmp    $0x10,%edx
  100167:	75 9a                	jne    100103 <interrupt+0x48>
  100169:	83 ca ff             	or     $0xffffffff,%edx
		run(current);

	case INT_SYS_FORK:
		// The 'sys_fork' system call should create a new process.
		// You will have to complete the do_fork() function!
		current->p_registers.reg_eax = do_fork(current);
  10016c:	89 53 20             	mov    %edx,0x20(%ebx)
		run(current);
  10016f:	83 ec 0c             	sub    $0xc,%esp
  100172:	ff 35 78 9e 10 00    	pushl  0x109e78
  100178:	e8 a3 02 00 00       	call   100420 <run>
	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule a
		// different process.  (MiniprocOS is cooperatively
		// scheduled, so we need a special system call to do this.)
		// The schedule() function picks another process and runs it.
		schedule();
  10017d:	e8 0a ff ff ff       	call   10008c <schedule>
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
  100182:	a1 78 9e 10 00       	mov    0x109e78,%eax
		current->p_exit_status = current->p_registers.reg_eax;
  100187:	8b 50 20             	mov    0x20(%eax),%edx
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
  10018a:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = current->p_registers.reg_eax;
  100191:	89 50 4c             	mov    %edx,0x4c(%eax)
        if (current->p_waiting)
  100194:	8b 40 50             	mov    0x50(%eax),%eax
  100197:	85 c0                	test   %eax,%eax
  100199:	74 0d                	je     1001a8 <interrupt+0xed>
            proc_array[(current->p_waiting)].p_state = P_RUNNABLE; //"wake up"
  10019b:	6b c0 54             	imul   $0x54,%eax,%eax
  10019e:	c7 80 18 91 10 00 01 	movl   $0x1,0x109118(%eax)
  1001a5:	00 00 00 
		schedule();
  1001a8:	e8 df fe ff ff       	call   10008c <schedule>
		// * A process that doesn't exist (p_state == P_EMPTY).
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
  1001ad:	a1 78 9e 10 00       	mov    0x109e78,%eax
  1001b2:	8b 50 20             	mov    0x20(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001b5:	8d 4a ff             	lea    -0x1(%edx),%ecx
  1001b8:	83 f9 0e             	cmp    $0xe,%ecx
  1001bb:	77 14                	ja     1001d1 <interrupt+0x116>
  1001bd:	3b 10                	cmp    (%eax),%edx
  1001bf:	74 10                	je     1001d1 <interrupt+0x116>
		    || proc_array[p].p_state == P_EMPTY)
  1001c1:	6b d2 54             	imul   $0x54,%edx,%edx
  1001c4:	8d 8a d8 90 10 00    	lea    0x1090d8(%edx),%ecx
  1001ca:	8b 59 40             	mov    0x40(%ecx),%ebx
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001cd:	85 db                	test   %ebx,%ebx
  1001cf:	75 09                	jne    1001da <interrupt+0x11f>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
  1001d1:	c7 40 20 ff ff ff ff 	movl   $0xffffffff,0x20(%eax)
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001d8:	eb 26                	jmp    100200 <interrupt+0x145>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE)
  1001da:	83 fb 03             	cmp    $0x3,%ebx
  1001dd:	75 12                	jne    1001f1 <interrupt+0x136>
        {
            proc_array[p].p_state = P_EMPTY; //reaped zombie
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  1001df:	8b 92 1c 91 10 00    	mov    0x10911c(%edx),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE)
        {
            proc_array[p].p_state = P_EMPTY; //reaped zombie
  1001e5:	c7 41 40 00 00 00 00 	movl   $0x0,0x40(%ecx)
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  1001ec:	89 50 20             	mov    %edx,0x20(%eax)
  1001ef:	eb 0f                	jmp    100200 <interrupt+0x145>
        }
		else //want to wait until the process is done
        {
			current->p_state = P_BLOCKED;
  1001f1:	c7 40 48 02 00 00 00 	movl   $0x2,0x48(%eax)
            proc_array[p].p_waiting = current->p_pid; //so we can "reawaken: later
  1001f8:	8b 00                	mov    (%eax),%eax
  1001fa:	89 82 20 91 10 00    	mov    %eax,0x109120(%edx)
        }
		schedule();
  100200:	e8 87 fe ff ff       	call   10008c <schedule>
  100205:	eb fe                	jmp    100205 <interrupt+0x14a>

00100207 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100207:	53                   	push   %ebx
  100208:	83 ec 0c             	sub    $0xc,%esp
	const char *s;
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10020b:	68 40 05 00 00       	push   $0x540
  100210:	6a 00                	push   $0x0
  100212:	68 d0 90 10 00       	push   $0x1090d0
  100217:	e8 40 03 00 00       	call   10055c <memset>
  10021c:	ba d0 90 10 00       	mov    $0x1090d0,%edx
  100221:	31 c0                	xor    %eax,%eax
  100223:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100226:	89 02                	mov    %eax,(%edx)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100228:	40                   	inc    %eax
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100229:	c7 42 48 00 00 00 00 	movl   $0x0,0x48(%edx)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100230:	83 c2 54             	add    $0x54,%edx
  100233:	83 f8 10             	cmp    $0x10,%eax
  100236:	75 ee                	jne    100226 <start+0x1f>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// The first process has process ID 1.
	current = &proc_array[1];
  100238:	c7 05 78 9e 10 00 24 	movl   $0x109124,0x109e78
  10023f:	91 10 00 

	// Set up x86 hardware, and initialize the first process's
	// special registers.  This only needs to be done once, at boot time.
	// All other processes' special registers can be copied from the
	// first process.
	segments_init();
  100242:	e8 71 00 00 00       	call   1002b8 <segments_init>
	special_registers_init(current);
  100247:	83 ec 0c             	sub    $0xc,%esp
  10024a:	ff 35 78 9e 10 00    	pushl  0x109e78
  100250:	e8 e2 01 00 00       	call   100437 <special_registers_init>

	// Erase the console, and initialize the cursor-position shared
	// variable to point to its upper left.
	console_clear();
  100255:	e8 2d 01 00 00       	call   100387 <console_clear>

	// Figure out which program to run.
	cursorpos = console_printf(cursorpos, 0x0700, "Type '1' to run mpos-app, or '2' to run mpos-app2.");
  10025a:	83 c4 0c             	add    $0xc,%esp
  10025d:	68 f0 09 10 00       	push   $0x1009f0
  100262:	68 00 07 00 00       	push   $0x700
  100267:	ff 35 00 00 06 00    	pushl  0x60000
  10026d:	e8 4f 07 00 00       	call   1009c1 <console_printf>
  100272:	83 c4 10             	add    $0x10,%esp
  100275:	a3 00 00 06 00       	mov    %eax,0x60000
	do {
		whichprocess = console_read_digit();
  10027a:	e8 4b 01 00 00       	call   1003ca <console_read_digit>
	} while (whichprocess != 1 && whichprocess != 2);
  10027f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100282:	83 fb 01             	cmp    $0x1,%ebx
  100285:	77 f3                	ja     10027a <start+0x73>
	console_clear();
  100287:	e8 fb 00 00 00       	call   100387 <console_clear>

	// Load the process application code and data into memory.
	// Store its entry point into the first process's EIP
	// (instruction pointer).
	program_loader(whichprocess - 1, &current->p_registers.reg_eip);
  10028c:	a1 78 9e 10 00       	mov    0x109e78,%eax
  100291:	83 c0 34             	add    $0x34,%eax
  100294:	52                   	push   %edx
  100295:	52                   	push   %edx
  100296:	50                   	push   %eax
  100297:	53                   	push   %ebx
  100298:	e8 cf 01 00 00       	call   10046c <program_loader>

	// Set the main process's stack pointer, ESP.
	current->p_registers.reg_esp = PROC1_STACK_ADDR + PROC_STACK_SIZE;
  10029d:	a1 78 9e 10 00       	mov    0x109e78,%eax
  1002a2:	c7 40 40 00 00 2c 00 	movl   $0x2c0000,0x40(%eax)

	// Mark the process as runnable!
	current->p_state = P_RUNNABLE;
  1002a9:	c7 40 48 01 00 00 00 	movl   $0x1,0x48(%eax)

	// Switch to the main process using run().
	run(current);
  1002b0:	89 04 24             	mov    %eax,(%esp)
  1002b3:	e8 68 01 00 00       	call   100420 <run>

001002b8 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002b8:	b8 10 96 10 00       	mov    $0x109610,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002bd:	b9 56 00 10 00       	mov    $0x100056,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002c2:	89 c2                	mov    %eax,%edx
  1002c4:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1002c7:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002c8:	bb 56 00 10 00       	mov    $0x100056,%ebx
  1002cd:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002d0:	66 a3 8e 1a 10 00    	mov    %ax,0x101a8e
  1002d6:	c1 e8 18             	shr    $0x18,%eax
  1002d9:	88 15 90 1a 10 00    	mov    %dl,0x101a90
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002df:	ba 78 96 10 00       	mov    $0x109678,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002e4:	a2 93 1a 10 00       	mov    %al,0x101a93
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002e9:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002eb:	66 c7 05 8c 1a 10 00 	movw   $0x68,0x101a8c
  1002f2:	68 00 
  1002f4:	c6 05 92 1a 10 00 40 	movb   $0x40,0x101a92
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1002fb:	c6 05 91 1a 10 00 89 	movb   $0x89,0x101a91

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100302:	c7 05 14 96 10 00 00 	movl   $0x80000,0x109614
  100309:	00 08 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  10030c:	66 c7 05 18 96 10 00 	movw   $0x10,0x109618
  100313:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100315:	66 89 0c c5 78 96 10 	mov    %cx,0x109678(,%eax,8)
  10031c:	00 
  10031d:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100324:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100329:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10032e:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100333:	40                   	inc    %eax
  100334:	3d 00 01 00 00       	cmp    $0x100,%eax
  100339:	75 da                	jne    100315 <segments_init+0x5d>
  10033b:	66 b8 30 00          	mov    $0x30,%ax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10033f:	ba 78 96 10 00       	mov    $0x109678,%edx
  100344:	8b 0c 85 a3 ff 0f 00 	mov    0xfffa3(,%eax,4),%ecx
  10034b:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100352:	66 89 0c c5 78 96 10 	mov    %cx,0x109678(,%eax,8)
  100359:	00 
  10035a:	c1 e9 10             	shr    $0x10,%ecx
  10035d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100362:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100367:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
  10036c:	40                   	inc    %eax
  10036d:	83 f8 3a             	cmp    $0x3a,%eax
  100370:	75 d2                	jne    100344 <segments_init+0x8c>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100372:	b0 28                	mov    $0x28,%al
  100374:	0f 01 15 54 1a 10 00 	lgdtl  0x101a54
  10037b:	0f 00 d8             	ltr    %ax
  10037e:	0f 01 1d 5c 1a 10 00 	lidtl  0x101a5c
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100385:	5b                   	pop    %ebx
  100386:	c3                   	ret    

00100387 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100387:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100388:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10038a:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10038b:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  100392:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100395:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  10039c:	00 20 07 
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10039f:	40                   	inc    %eax
  1003a0:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  1003a5:	75 ee                	jne    100395 <console_clear+0xe>
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1003a7:	be d4 03 00 00       	mov    $0x3d4,%esi
  1003ac:	b0 0e                	mov    $0xe,%al
  1003ae:	89 f2                	mov    %esi,%edx
  1003b0:	ee                   	out    %al,(%dx)
  1003b1:	31 c9                	xor    %ecx,%ecx
  1003b3:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1003b8:	88 c8                	mov    %cl,%al
  1003ba:	89 da                	mov    %ebx,%edx
  1003bc:	ee                   	out    %al,(%dx)
  1003bd:	b0 0f                	mov    $0xf,%al
  1003bf:	89 f2                	mov    %esi,%edx
  1003c1:	ee                   	out    %al,(%dx)
  1003c2:	88 c8                	mov    %cl,%al
  1003c4:	89 da                	mov    %ebx,%edx
  1003c6:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1003c7:	5b                   	pop    %ebx
  1003c8:	5e                   	pop    %esi
  1003c9:	c3                   	ret    

001003ca <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1003ca:	ba 64 00 00 00       	mov    $0x64,%edx
  1003cf:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1003d0:	a8 01                	test   $0x1,%al
  1003d2:	74 45                	je     100419 <console_read_digit+0x4f>
  1003d4:	b2 60                	mov    $0x60,%dl
  1003d6:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1003d7:	8d 50 fe             	lea    -0x2(%eax),%edx
  1003da:	80 fa 08             	cmp    $0x8,%dl
  1003dd:	77 05                	ja     1003e4 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1003df:	0f b6 c0             	movzbl %al,%eax
  1003e2:	48                   	dec    %eax
  1003e3:	c3                   	ret    
	else if (data == 0x0B)
  1003e4:	3c 0b                	cmp    $0xb,%al
  1003e6:	74 35                	je     10041d <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1003e8:	8d 50 b9             	lea    -0x47(%eax),%edx
  1003eb:	80 fa 02             	cmp    $0x2,%dl
  1003ee:	77 07                	ja     1003f7 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1003f0:	0f b6 c0             	movzbl %al,%eax
  1003f3:	83 e8 40             	sub    $0x40,%eax
  1003f6:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1003f7:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1003fa:	80 fa 02             	cmp    $0x2,%dl
  1003fd:	77 07                	ja     100406 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1003ff:	0f b6 c0             	movzbl %al,%eax
  100402:	83 e8 47             	sub    $0x47,%eax
  100405:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100406:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100409:	80 fa 02             	cmp    $0x2,%dl
  10040c:	77 07                	ja     100415 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10040e:	0f b6 c0             	movzbl %al,%eax
  100411:	83 e8 4e             	sub    $0x4e,%eax
  100414:	c3                   	ret    
	else if (data == 0x53)
  100415:	3c 53                	cmp    $0x53,%al
  100417:	74 04                	je     10041d <console_read_digit+0x53>
  100419:	83 c8 ff             	or     $0xffffffff,%eax
  10041c:	c3                   	ret    
  10041d:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10041f:	c3                   	ret    

00100420 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100420:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100424:	a3 78 9e 10 00       	mov    %eax,0x109e78

	asm volatile("movl %0,%%esp\n\t"
  100429:	83 c0 04             	add    $0x4,%eax
  10042c:	89 c4                	mov    %eax,%esp
  10042e:	61                   	popa   
  10042f:	07                   	pop    %es
  100430:	1f                   	pop    %ds
  100431:	83 c4 08             	add    $0x8,%esp
  100434:	cf                   	iret   
  100435:	eb fe                	jmp    100435 <run+0x15>

00100437 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100437:	53                   	push   %ebx
  100438:	83 ec 0c             	sub    $0xc,%esp
  10043b:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10043f:	6a 44                	push   $0x44
  100441:	6a 00                	push   $0x0
  100443:	8d 43 04             	lea    0x4(%ebx),%eax
  100446:	50                   	push   %eax
  100447:	e8 10 01 00 00       	call   10055c <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  10044c:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100452:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100458:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10045e:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
}
  100464:	83 c4 18             	add    $0x18,%esp
  100467:	5b                   	pop    %ebx
  100468:	c3                   	ret    
  100469:	90                   	nop
  10046a:	90                   	nop
  10046b:	90                   	nop

0010046c <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  10046c:	55                   	push   %ebp
  10046d:	57                   	push   %edi
  10046e:	56                   	push   %esi
  10046f:	53                   	push   %ebx
  100470:	83 ec 1c             	sub    $0x1c,%esp
  100473:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100477:	83 f8 01             	cmp    $0x1,%eax
  10047a:	7f 04                	jg     100480 <program_loader+0x14>
  10047c:	85 c0                	test   %eax,%eax
  10047e:	79 02                	jns    100482 <program_loader+0x16>
  100480:	eb fe                	jmp    100480 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100482:	8b 34 c5 94 1a 10 00 	mov    0x101a94(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100489:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10048f:	74 02                	je     100493 <program_loader+0x27>
  100491:	eb fe                	jmp    100491 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100493:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100496:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10049a:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  10049c:	c1 e5 05             	shl    $0x5,%ebp
  10049f:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1004a2:	eb 3f                	jmp    1004e3 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1004a4:	83 3b 01             	cmpl   $0x1,(%ebx)
  1004a7:	75 37                	jne    1004e0 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1004a9:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1004ac:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1004af:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1004b2:	01 c7                	add    %eax,%edi
	memsz += va;
  1004b4:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1004b6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1004bb:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1004bf:	52                   	push   %edx
  1004c0:	89 fa                	mov    %edi,%edx
  1004c2:	29 c2                	sub    %eax,%edx
  1004c4:	52                   	push   %edx
  1004c5:	8b 53 04             	mov    0x4(%ebx),%edx
  1004c8:	01 f2                	add    %esi,%edx
  1004ca:	52                   	push   %edx
  1004cb:	50                   	push   %eax
  1004cc:	e8 27 00 00 00       	call   1004f8 <memcpy>
  1004d1:	83 c4 10             	add    $0x10,%esp
  1004d4:	eb 04                	jmp    1004da <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1004d6:	c6 07 00             	movb   $0x0,(%edi)
  1004d9:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1004da:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1004de:	72 f6                	jb     1004d6 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1004e0:	83 c3 20             	add    $0x20,%ebx
  1004e3:	39 eb                	cmp    %ebp,%ebx
  1004e5:	72 bd                	jb     1004a4 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1004e7:	8b 56 18             	mov    0x18(%esi),%edx
  1004ea:	8b 44 24 34          	mov    0x34(%esp),%eax
  1004ee:	89 10                	mov    %edx,(%eax)
}
  1004f0:	83 c4 1c             	add    $0x1c,%esp
  1004f3:	5b                   	pop    %ebx
  1004f4:	5e                   	pop    %esi
  1004f5:	5f                   	pop    %edi
  1004f6:	5d                   	pop    %ebp
  1004f7:	c3                   	ret    

001004f8 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1004f8:	56                   	push   %esi
  1004f9:	31 d2                	xor    %edx,%edx
  1004fb:	53                   	push   %ebx
  1004fc:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100500:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100504:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100508:	eb 08                	jmp    100512 <memcpy+0x1a>
		*d++ = *s++;
  10050a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10050d:	4e                   	dec    %esi
  10050e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100511:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100512:	85 f6                	test   %esi,%esi
  100514:	75 f4                	jne    10050a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100516:	5b                   	pop    %ebx
  100517:	5e                   	pop    %esi
  100518:	c3                   	ret    

00100519 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100519:	57                   	push   %edi
  10051a:	56                   	push   %esi
  10051b:	53                   	push   %ebx
  10051c:	8b 44 24 10          	mov    0x10(%esp),%eax
  100520:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100524:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100528:	39 c7                	cmp    %eax,%edi
  10052a:	73 26                	jae    100552 <memmove+0x39>
  10052c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10052f:	39 c6                	cmp    %eax,%esi
  100531:	76 1f                	jbe    100552 <memmove+0x39>
		s += n, d += n;
  100533:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100536:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100538:	eb 07                	jmp    100541 <memmove+0x28>
			*--d = *--s;
  10053a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  10053d:	4a                   	dec    %edx
  10053e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100541:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100542:	85 d2                	test   %edx,%edx
  100544:	75 f4                	jne    10053a <memmove+0x21>
  100546:	eb 10                	jmp    100558 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100548:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10054b:	4a                   	dec    %edx
  10054c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10054f:	41                   	inc    %ecx
  100550:	eb 02                	jmp    100554 <memmove+0x3b>
  100552:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100554:	85 d2                	test   %edx,%edx
  100556:	75 f0                	jne    100548 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100558:	5b                   	pop    %ebx
  100559:	5e                   	pop    %esi
  10055a:	5f                   	pop    %edi
  10055b:	c3                   	ret    

0010055c <memset>:

void *
memset(void *v, int c, size_t n)
{
  10055c:	53                   	push   %ebx
  10055d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100561:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100565:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100569:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10056b:	eb 04                	jmp    100571 <memset+0x15>
		*p++ = c;
  10056d:	88 1a                	mov    %bl,(%edx)
  10056f:	49                   	dec    %ecx
  100570:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100571:	85 c9                	test   %ecx,%ecx
  100573:	75 f8                	jne    10056d <memset+0x11>
		*p++ = c;
	return v;
}
  100575:	5b                   	pop    %ebx
  100576:	c3                   	ret    

00100577 <strlen>:

size_t
strlen(const char *s)
{
  100577:	8b 54 24 04          	mov    0x4(%esp),%edx
  10057b:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10057d:	eb 01                	jmp    100580 <strlen+0x9>
		++n;
  10057f:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100580:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100584:	75 f9                	jne    10057f <strlen+0x8>
		++n;
	return n;
}
  100586:	c3                   	ret    

00100587 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100587:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10058b:	31 c0                	xor    %eax,%eax
  10058d:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100591:	eb 01                	jmp    100594 <strnlen+0xd>
		++n;
  100593:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100594:	39 d0                	cmp    %edx,%eax
  100596:	74 06                	je     10059e <strnlen+0x17>
  100598:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  10059c:	75 f5                	jne    100593 <strnlen+0xc>
		++n;
	return n;
}
  10059e:	c3                   	ret    

0010059f <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10059f:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1005a0:	3d a0 8f 0b 00       	cmp    $0xb8fa0,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1005a5:	53                   	push   %ebx
  1005a6:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1005a8:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  1005ad:	0f 43 d8             	cmovae %eax,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1005b0:	80 fa 0a             	cmp    $0xa,%dl
  1005b3:	75 2c                	jne    1005e1 <console_putc+0x42>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1005b5:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1005bb:	be 50 00 00 00       	mov    $0x50,%esi
  1005c0:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1005c2:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1005c5:	99                   	cltd   
  1005c6:	f7 fe                	idiv   %esi
  1005c8:	89 de                	mov    %ebx,%esi
  1005ca:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1005cc:	eb 07                	jmp    1005d5 <console_putc+0x36>
			*cursor++ = ' ' | color;
  1005ce:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1005d1:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1005d2:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1005d5:	83 f8 50             	cmp    $0x50,%eax
  1005d8:	75 f4                	jne    1005ce <console_putc+0x2f>
  1005da:	29 d0                	sub    %edx,%eax
  1005dc:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1005df:	eb 0b                	jmp    1005ec <console_putc+0x4d>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1005e1:	0f b6 d2             	movzbl %dl,%edx
  1005e4:	09 ca                	or     %ecx,%edx
  1005e6:	66 89 13             	mov    %dx,(%ebx)
  1005e9:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1005ec:	5b                   	pop    %ebx
  1005ed:	5e                   	pop    %esi
  1005ee:	c3                   	ret    

001005ef <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1005ef:	56                   	push   %esi
  1005f0:	53                   	push   %ebx
  1005f1:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1005f5:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1005f8:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1005fc:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100601:	75 04                	jne    100607 <fill_numbuf+0x18>
  100603:	85 d2                	test   %edx,%edx
  100605:	74 10                	je     100617 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100607:	89 d0                	mov    %edx,%eax
  100609:	31 d2                	xor    %edx,%edx
  10060b:	f7 f1                	div    %ecx
  10060d:	4b                   	dec    %ebx
  10060e:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100611:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100613:	89 c2                	mov    %eax,%edx
  100615:	eb ec                	jmp    100603 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100617:	89 d8                	mov    %ebx,%eax
  100619:	5b                   	pop    %ebx
  10061a:	5e                   	pop    %esi
  10061b:	c3                   	ret    

0010061c <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10061c:	55                   	push   %ebp
  10061d:	57                   	push   %edi
  10061e:	56                   	push   %esi
  10061f:	53                   	push   %ebx
  100620:	83 ec 38             	sub    $0x38,%esp
  100623:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100627:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10062b:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10062f:	e9 62 03 00 00       	jmp    100996 <console_vprintf+0x37a>
		if (*format != '%') {
  100634:	80 fa 25             	cmp    $0x25,%dl
  100637:	74 13                	je     10064c <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100639:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10063d:	0f b6 d2             	movzbl %dl,%edx
  100640:	89 f0                	mov    %esi,%eax
  100642:	e8 58 ff ff ff       	call   10059f <console_putc>
  100647:	e9 47 03 00 00       	jmp    100993 <console_vprintf+0x377>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10064c:	47                   	inc    %edi
  10064d:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100654:	00 
  100655:	eb 12                	jmp    100669 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100657:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100658:	8a 11                	mov    (%ecx),%dl
  10065a:	84 d2                	test   %dl,%dl
  10065c:	74 1a                	je     100678 <console_vprintf+0x5c>
  10065e:	89 e8                	mov    %ebp,%eax
  100660:	38 c2                	cmp    %al,%dl
  100662:	75 f3                	jne    100657 <console_vprintf+0x3b>
  100664:	e9 41 03 00 00       	jmp    1009aa <console_vprintf+0x38e>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100669:	8a 17                	mov    (%edi),%dl
  10066b:	84 d2                	test   %dl,%dl
  10066d:	74 0b                	je     10067a <console_vprintf+0x5e>
  10066f:	b9 24 0a 10 00       	mov    $0x100a24,%ecx
  100674:	89 d5                	mov    %edx,%ebp
  100676:	eb e0                	jmp    100658 <console_vprintf+0x3c>
  100678:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  10067a:	8d 42 cf             	lea    -0x31(%edx),%eax
  10067d:	3c 08                	cmp    $0x8,%al
  10067f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100686:	00 
  100687:	76 13                	jbe    10069c <console_vprintf+0x80>
  100689:	eb 1d                	jmp    1006a8 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10068b:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100690:	0f be c0             	movsbl %al,%eax
  100693:	47                   	inc    %edi
  100694:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100698:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10069c:	8a 07                	mov    (%edi),%al
  10069e:	8d 50 d0             	lea    -0x30(%eax),%edx
  1006a1:	80 fa 09             	cmp    $0x9,%dl
  1006a4:	76 e5                	jbe    10068b <console_vprintf+0x6f>
  1006a6:	eb 18                	jmp    1006c0 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1006a8:	80 fa 2a             	cmp    $0x2a,%dl
  1006ab:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1006b2:	ff 
  1006b3:	75 0b                	jne    1006c0 <console_vprintf+0xa4>
			width = va_arg(val, int);
  1006b5:	83 c3 04             	add    $0x4,%ebx
			++format;
  1006b8:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1006b9:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1006bc:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1006c0:	83 cd ff             	or     $0xffffffff,%ebp
  1006c3:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1006c6:	75 37                	jne    1006ff <console_vprintf+0xe3>
			++format;
  1006c8:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1006c9:	31 ed                	xor    %ebp,%ebp
  1006cb:	8a 07                	mov    (%edi),%al
  1006cd:	8d 50 d0             	lea    -0x30(%eax),%edx
  1006d0:	80 fa 09             	cmp    $0x9,%dl
  1006d3:	76 0d                	jbe    1006e2 <console_vprintf+0xc6>
  1006d5:	eb 17                	jmp    1006ee <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1006d7:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1006da:	0f be c0             	movsbl %al,%eax
  1006dd:	47                   	inc    %edi
  1006de:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1006e2:	8a 07                	mov    (%edi),%al
  1006e4:	8d 50 d0             	lea    -0x30(%eax),%edx
  1006e7:	80 fa 09             	cmp    $0x9,%dl
  1006ea:	76 eb                	jbe    1006d7 <console_vprintf+0xbb>
  1006ec:	eb 11                	jmp    1006ff <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1006ee:	3c 2a                	cmp    $0x2a,%al
  1006f0:	75 0b                	jne    1006fd <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1006f2:	83 c3 04             	add    $0x4,%ebx
				++format;
  1006f5:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1006f6:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1006f9:	85 ed                	test   %ebp,%ebp
  1006fb:	79 02                	jns    1006ff <console_vprintf+0xe3>
  1006fd:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1006ff:	8a 07                	mov    (%edi),%al
  100701:	3c 64                	cmp    $0x64,%al
  100703:	74 34                	je     100739 <console_vprintf+0x11d>
  100705:	7f 1d                	jg     100724 <console_vprintf+0x108>
  100707:	3c 58                	cmp    $0x58,%al
  100709:	0f 84 a2 00 00 00    	je     1007b1 <console_vprintf+0x195>
  10070f:	3c 63                	cmp    $0x63,%al
  100711:	0f 84 bf 00 00 00    	je     1007d6 <console_vprintf+0x1ba>
  100717:	3c 43                	cmp    $0x43,%al
  100719:	0f 85 d0 00 00 00    	jne    1007ef <console_vprintf+0x1d3>
  10071f:	e9 a3 00 00 00       	jmp    1007c7 <console_vprintf+0x1ab>
  100724:	3c 75                	cmp    $0x75,%al
  100726:	74 4d                	je     100775 <console_vprintf+0x159>
  100728:	3c 78                	cmp    $0x78,%al
  10072a:	74 5c                	je     100788 <console_vprintf+0x16c>
  10072c:	3c 73                	cmp    $0x73,%al
  10072e:	0f 85 bb 00 00 00    	jne    1007ef <console_vprintf+0x1d3>
  100734:	e9 86 00 00 00       	jmp    1007bf <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100739:	83 c3 04             	add    $0x4,%ebx
  10073c:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10073f:	89 d1                	mov    %edx,%ecx
  100741:	c1 f9 1f             	sar    $0x1f,%ecx
  100744:	89 0c 24             	mov    %ecx,(%esp)
  100747:	31 ca                	xor    %ecx,%edx
  100749:	55                   	push   %ebp
  10074a:	29 ca                	sub    %ecx,%edx
  10074c:	68 2c 0a 10 00       	push   $0x100a2c
  100751:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100756:	8d 44 24 40          	lea    0x40(%esp),%eax
  10075a:	e8 90 fe ff ff       	call   1005ef <fill_numbuf>
  10075f:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100763:	58                   	pop    %eax
  100764:	5a                   	pop    %edx
  100765:	ba 01 00 00 00       	mov    $0x1,%edx
  10076a:	8b 04 24             	mov    (%esp),%eax
  10076d:	83 e0 01             	and    $0x1,%eax
  100770:	e9 a6 00 00 00       	jmp    10081b <console_vprintf+0x1ff>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100775:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100778:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10077d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100780:	55                   	push   %ebp
  100781:	68 2c 0a 10 00       	push   $0x100a2c
  100786:	eb 11                	jmp    100799 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100788:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10078b:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10078e:	55                   	push   %ebp
  10078f:	68 40 0a 10 00       	push   $0x100a40
  100794:	b9 10 00 00 00       	mov    $0x10,%ecx
  100799:	8d 44 24 40          	lea    0x40(%esp),%eax
  10079d:	e8 4d fe ff ff       	call   1005ef <fill_numbuf>
  1007a2:	ba 01 00 00 00       	mov    $0x1,%edx
  1007a7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1007ab:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1007ad:	59                   	pop    %ecx
  1007ae:	59                   	pop    %ecx
  1007af:	eb 6a                	jmp    10081b <console_vprintf+0x1ff>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1007b1:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1007b4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007b7:	55                   	push   %ebp
  1007b8:	68 2c 0a 10 00       	push   $0x100a2c
  1007bd:	eb d5                	jmp    100794 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1007bf:	83 c3 04             	add    $0x4,%ebx
  1007c2:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1007c5:	eb 41                	jmp    100808 <console_vprintf+0x1ec>
			break;
		case 'C':
			color = va_arg(val, int);
  1007c7:	83 c3 04             	add    $0x4,%ebx
  1007ca:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007cd:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1007d1:	e9 bf 01 00 00       	jmp    100995 <console_vprintf+0x379>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1007d6:	83 c3 04             	add    $0x4,%ebx
  1007d9:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1007dc:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1007e0:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1007e5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1007e9:	88 44 24 24          	mov    %al,0x24(%esp)
  1007ed:	eb 28                	jmp    100817 <console_vprintf+0x1fb>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1007ef:	84 c0                	test   %al,%al
  1007f1:	b2 25                	mov    $0x25,%dl
  1007f3:	0f 44 c2             	cmove  %edx,%eax
  1007f6:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1007fa:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1007ff:	80 3f 00             	cmpb   $0x0,(%edi)
  100802:	74 0a                	je     10080e <console_vprintf+0x1f2>
  100804:	8d 44 24 24          	lea    0x24(%esp),%eax
  100808:	89 44 24 04          	mov    %eax,0x4(%esp)
  10080c:	eb 09                	jmp    100817 <console_vprintf+0x1fb>
				format--;
  10080e:	8d 54 24 24          	lea    0x24(%esp),%edx
  100812:	4f                   	dec    %edi
  100813:	89 54 24 04          	mov    %edx,0x4(%esp)
  100817:	31 d2                	xor    %edx,%edx
  100819:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10081b:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10081d:	83 fd ff             	cmp    $0xffffffff,%ebp
  100820:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100827:	74 1f                	je     100848 <console_vprintf+0x22c>
  100829:	89 04 24             	mov    %eax,(%esp)
  10082c:	eb 01                	jmp    10082f <console_vprintf+0x213>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  10082e:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10082f:	39 e9                	cmp    %ebp,%ecx
  100831:	74 0a                	je     10083d <console_vprintf+0x221>
  100833:	8b 44 24 04          	mov    0x4(%esp),%eax
  100837:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  10083b:	75 f1                	jne    10082e <console_vprintf+0x212>
  10083d:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100840:	89 0c 24             	mov    %ecx,(%esp)
  100843:	eb 1f                	jmp    100864 <console_vprintf+0x248>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100845:	42                   	inc    %edx
  100846:	eb 09                	jmp    100851 <console_vprintf+0x235>
  100848:	89 d1                	mov    %edx,%ecx
  10084a:	8b 14 24             	mov    (%esp),%edx
  10084d:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100851:	8b 44 24 04          	mov    0x4(%esp),%eax
  100855:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100859:	75 ea                	jne    100845 <console_vprintf+0x229>
  10085b:	8b 44 24 08          	mov    0x8(%esp),%eax
  10085f:	89 14 24             	mov    %edx,(%esp)
  100862:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100864:	85 c0                	test   %eax,%eax
  100866:	74 0c                	je     100874 <console_vprintf+0x258>
  100868:	84 d2                	test   %dl,%dl
  10086a:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100871:	00 
  100872:	75 24                	jne    100898 <console_vprintf+0x27c>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100874:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100879:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100880:	00 
  100881:	75 15                	jne    100898 <console_vprintf+0x27c>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100883:	8b 44 24 14          	mov    0x14(%esp),%eax
  100887:	83 e0 08             	and    $0x8,%eax
  10088a:	83 f8 01             	cmp    $0x1,%eax
  10088d:	19 c9                	sbb    %ecx,%ecx
  10088f:	f7 d1                	not    %ecx
  100891:	83 e1 20             	and    $0x20,%ecx
  100894:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100898:	3b 2c 24             	cmp    (%esp),%ebp
  10089b:	7e 0d                	jle    1008aa <console_vprintf+0x28e>
  10089d:	84 d2                	test   %dl,%dl
  10089f:	74 41                	je     1008e2 <console_vprintf+0x2c6>
			zeros = precision - len;
  1008a1:	2b 2c 24             	sub    (%esp),%ebp
  1008a4:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1008a8:	eb 40                	jmp    1008ea <console_vprintf+0x2ce>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008aa:	84 d2                	test   %dl,%dl
  1008ac:	74 34                	je     1008e2 <console_vprintf+0x2c6>
  1008ae:	8b 44 24 14          	mov    0x14(%esp),%eax
  1008b2:	83 e0 06             	and    $0x6,%eax
  1008b5:	83 f8 02             	cmp    $0x2,%eax
  1008b8:	75 28                	jne    1008e2 <console_vprintf+0x2c6>
  1008ba:	45                   	inc    %ebp
  1008bb:	75 25                	jne    1008e2 <console_vprintf+0x2c6>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1008bd:	31 c0                	xor    %eax,%eax
  1008bf:	8b 14 24             	mov    (%esp),%edx
  1008c2:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1008c7:	0f 95 c0             	setne  %al
  1008ca:	8d 14 10             	lea    (%eax,%edx,1),%edx
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008cd:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1008d1:	7d 0f                	jge    1008e2 <console_vprintf+0x2c6>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  1008d3:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1008d7:	2b 14 24             	sub    (%esp),%edx
  1008da:	29 c2                	sub    %eax,%edx
  1008dc:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008e0:	eb 08                	jmp    1008ea <console_vprintf+0x2ce>
  1008e2:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1008e9:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1008ea:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1008ee:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1008f0:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1008f4:	2b 2c 24             	sub    (%esp),%ebp
  1008f7:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1008fc:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1008ff:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100902:	29 c5                	sub    %eax,%ebp
  100904:	89 f0                	mov    %esi,%eax
  100906:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10090a:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  10090e:	eb 0f                	jmp    10091f <console_vprintf+0x303>
			cursor = console_putc(cursor, ' ', color);
  100910:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100914:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100919:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  10091a:	e8 80 fc ff ff       	call   10059f <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10091f:	85 ed                	test   %ebp,%ebp
  100921:	7e 07                	jle    10092a <console_vprintf+0x30e>
  100923:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100928:	74 e6                	je     100910 <console_vprintf+0x2f4>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  10092a:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  10092f:	89 c6                	mov    %eax,%esi
  100931:	74 23                	je     100956 <console_vprintf+0x33a>
			cursor = console_putc(cursor, negative, color);
  100933:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100938:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10093c:	e8 5e fc ff ff       	call   10059f <console_putc>
  100941:	89 c6                	mov    %eax,%esi
  100943:	eb 11                	jmp    100956 <console_vprintf+0x33a>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100945:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100949:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  10094e:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  10094f:	e8 4b fc ff ff       	call   10059f <console_putc>
  100954:	eb 06                	jmp    10095c <console_vprintf+0x340>
  100956:	89 f0                	mov    %esi,%eax
  100958:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  10095c:	85 f6                	test   %esi,%esi
  10095e:	7f e5                	jg     100945 <console_vprintf+0x329>
  100960:	8b 34 24             	mov    (%esp),%esi
  100963:	eb 15                	jmp    10097a <console_vprintf+0x35e>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100965:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100969:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  10096a:	0f b6 11             	movzbl (%ecx),%edx
  10096d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100971:	e8 29 fc ff ff       	call   10059f <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100976:	ff 44 24 04          	incl   0x4(%esp)
  10097a:	85 f6                	test   %esi,%esi
  10097c:	7f e7                	jg     100965 <console_vprintf+0x349>
  10097e:	eb 0f                	jmp    10098f <console_vprintf+0x373>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100980:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100984:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100989:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  10098a:	e8 10 fc ff ff       	call   10059f <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  10098f:	85 ed                	test   %ebp,%ebp
  100991:	7f ed                	jg     100980 <console_vprintf+0x364>
  100993:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100995:	47                   	inc    %edi
  100996:	8a 17                	mov    (%edi),%dl
  100998:	84 d2                	test   %dl,%dl
  10099a:	0f 85 94 fc ff ff    	jne    100634 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  1009a0:	83 c4 38             	add    $0x38,%esp
  1009a3:	89 f0                	mov    %esi,%eax
  1009a5:	5b                   	pop    %ebx
  1009a6:	5e                   	pop    %esi
  1009a7:	5f                   	pop    %edi
  1009a8:	5d                   	pop    %ebp
  1009a9:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  1009aa:	81 e9 24 0a 10 00    	sub    $0x100a24,%ecx
  1009b0:	b8 01 00 00 00       	mov    $0x1,%eax
  1009b5:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1009b7:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  1009b8:	09 44 24 14          	or     %eax,0x14(%esp)
  1009bc:	e9 a8 fc ff ff       	jmp    100669 <console_vprintf+0x4d>

001009c1 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  1009c1:	8d 44 24 10          	lea    0x10(%esp),%eax
  1009c5:	50                   	push   %eax
  1009c6:	ff 74 24 10          	pushl  0x10(%esp)
  1009ca:	ff 74 24 10          	pushl  0x10(%esp)
  1009ce:	ff 74 24 10          	pushl  0x10(%esp)
  1009d2:	e8 45 fc ff ff       	call   10061c <console_vprintf>
  1009d7:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  1009da:	c3                   	ret    
