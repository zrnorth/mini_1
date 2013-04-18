
obj/mpos-app:     file format elf32-i386


Disassembly of section .text:

00200000 <app_printf>:

static void app_printf(const char *format, ...) __attribute__((noinline));

static void
app_printf(const char *format, ...)
{
  200000:	83 ec 0c             	sub    $0xc,%esp
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  200003:	cd 30                	int    $0x30
static void
app_printf(const char *format, ...)
{
	// set default color based on currently running process
	int color = sys_getpid();
	if (color < 0)
  200005:	85 c0                	test   %eax,%eax
  200007:	ba 00 07 00 00       	mov    $0x700,%edx
  20000c:	78 13                	js     200021 <app_printf+0x21>
		color = 0x0700;
	else {
		static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
		color = col[color % sizeof(col)] << 8;
  20000e:	b9 05 00 00 00       	mov    $0x5,%ecx
  200013:	31 d2                	xor    %edx,%edx
  200015:	f7 f1                	div    %ecx
  200017:	0f b6 92 74 06 20 00 	movzbl 0x200674(%edx),%edx
  20001e:	c1 e2 08             	shl    $0x8,%edx
	}

	va_list val;
	va_start(val, format);
	cursorpos = console_vprintf(cursorpos, color, format, val);
  200021:	8d 44 24 14          	lea    0x14(%esp),%eax
  200025:	50                   	push   %eax
  200026:	ff 74 24 14          	pushl  0x14(%esp)
  20002a:	52                   	push   %edx
  20002b:	ff 35 00 00 06 00    	pushl  0x60000
  200031:	e8 f6 01 00 00       	call   20022c <console_vprintf>
  200036:	a3 00 00 06 00       	mov    %eax,0x60000
	va_end(val);
}
  20003b:	83 c4 1c             	add    $0x1c,%esp
  20003e:	c3                   	ret    

0020003f <run_child>:
	}
}

void
run_child(void)
{
  20003f:	83 ec 24             	sub    $0x24,%esp
	int i;
	volatile int checker = 1; /* This variable checks that you correctly
  200042:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%esp)
  200049:	00 
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  20004a:	cd 30                	int    $0x30
				     gave this process a new stack.
				     If the parent's 'checker' changed value
				     after the child ran, there's a problem! */

	app_printf("Child process %d!\n", sys_getpid());
  20004c:	50                   	push   %eax
  20004d:	68 ec 05 20 00       	push   $0x2005ec
  200052:	e8 a9 ff ff ff       	call   200000 <app_printf>
  200057:	31 c0                	xor    %eax,%eax
  200059:	83 c4 10             	add    $0x10,%esp

static inline void
sys_yield(void)
{
	// This system call has no return values, so there's no '=a' clause.
	asm volatile("int %0\n"
  20005c:	cd 32                	int    $0x32

	// Yield a couple times to help people test Exercise 3
	for (i = 0; i < 20; i++)
  20005e:	40                   	inc    %eax
  20005f:	83 f8 14             	cmp    $0x14,%eax
  200062:	75 f8                	jne    20005c <run_child+0x1d>
	// the 'int' instruction.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  200064:	66 b8 e8 03          	mov    $0x3e8,%ax
  200068:	cd 33                	int    $0x33
  20006a:	eb fe                	jmp    20006a <run_child+0x2b>

0020006c <start>:

void run_child(void);

void
start(void)
{
  20006c:	53                   	push   %ebx
  20006d:	83 ec 24             	sub    $0x24,%esp
	volatile int checker = 0; /* This variable checks that you correctly
  200070:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  200077:	00 
				     gave the child process a new stack. */
	pid_t p;
	int status;

	app_printf("About to start a new process...\n");
  200078:	68 ff 05 20 00       	push   $0x2005ff
  20007d:	e8 7e ff ff ff       	call   200000 <app_printf>
sys_fork(void)
{
	// This system call follows the same pattern as sys_getpid().

	pid_t result;
	asm volatile("int %1\n"
  200082:	cd 31                	int    $0x31

	p = sys_fork();
	if (p == 0)
  200084:	83 c4 10             	add    $0x10,%esp
  200087:	83 f8 00             	cmp    $0x0,%eax
  20008a:	89 c3                	mov    %eax,%ebx
  20008c:	75 09                	jne    200097 <start+0x2b>

	} else {
		app_printf("Error!\n");
		sys_exit(1);
	}
}
  20008e:	83 c4 18             	add    $0x18,%esp
  200091:	5b                   	pop    %ebx

	app_printf("About to start a new process...\n");

	p = sys_fork();
	if (p == 0)
		run_child();
  200092:	e9 a8 ff ff ff       	jmp    20003f <run_child>
	else if (p > 0) {
  200097:	7e 54                	jle    2000ed <start+0x81>
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  200099:	cd 30                	int    $0x30
		app_printf("Main process %d!\n", sys_getpid());
  20009b:	52                   	push   %edx
  20009c:	52                   	push   %edx
  20009d:	50                   	push   %eax
  20009e:	68 20 06 20 00       	push   $0x200620
  2000a3:	e8 58 ff ff ff       	call   200000 <app_printf>
  2000a8:	83 c4 10             	add    $0x10,%esp

static inline int
sys_wait(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  2000ab:	89 d8                	mov    %ebx,%eax
  2000ad:	cd 34                	int    $0x34
		do {
			status = sys_wait(p);
		} while (status == WAIT_TRYAGAIN);
  2000af:	83 f8 fe             	cmp    $0xfffffffe,%eax
  2000b2:	89 c2                	mov    %eax,%edx
  2000b4:	74 f5                	je     2000ab <start+0x3f>
		app_printf("Child %d exited with status %d!\n", p, status);
  2000b6:	50                   	push   %eax
  2000b7:	52                   	push   %edx
  2000b8:	53                   	push   %ebx
  2000b9:	68 32 06 20 00       	push   $0x200632
  2000be:	e8 3d ff ff ff       	call   200000 <app_printf>

		// Check whether the child process corrupted our stack.
		// (This check doesn't find all errors, but it helps.)
		if (checker != 0) {
  2000c3:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2000c7:	83 c4 10             	add    $0x10,%esp
  2000ca:	85 c0                	test   %eax,%eax
  2000cc:	74 19                	je     2000e7 <start+0x7b>
			app_printf("Error: stack collision!\n");
  2000ce:	83 ec 0c             	sub    $0xc,%esp
  2000d1:	68 53 06 20 00       	push   $0x200653
  2000d6:	e8 25 ff ff ff       	call   200000 <app_printf>
	// the 'int' instruction.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  2000db:	b8 01 00 00 00       	mov    $0x1,%eax
  2000e0:	cd 33                	int    $0x33
  2000e2:	83 c4 10             	add    $0x10,%esp
  2000e5:	eb fe                	jmp    2000e5 <start+0x79>
  2000e7:	31 c0                	xor    %eax,%eax
  2000e9:	cd 33                	int    $0x33
  2000eb:	eb fe                	jmp    2000eb <start+0x7f>
			sys_exit(1);
		} else
			sys_exit(0);

	} else {
		app_printf("Error!\n");
  2000ed:	83 ec 0c             	sub    $0xc,%esp
  2000f0:	68 6c 06 20 00       	push   $0x20066c
  2000f5:	e8 06 ff ff ff       	call   200000 <app_printf>
  2000fa:	b8 01 00 00 00       	mov    $0x1,%eax
  2000ff:	cd 33                	int    $0x33
  200101:	83 c4 10             	add    $0x10,%esp
  200104:	eb fe                	jmp    200104 <start+0x98>
  200106:	90                   	nop
  200107:	90                   	nop

00200108 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  200108:	56                   	push   %esi
  200109:	31 d2                	xor    %edx,%edx
  20010b:	53                   	push   %ebx
  20010c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200110:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  200114:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  200118:	eb 08                	jmp    200122 <memcpy+0x1a>
		*d++ = *s++;
  20011a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  20011d:	4e                   	dec    %esi
  20011e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  200121:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  200122:	85 f6                	test   %esi,%esi
  200124:	75 f4                	jne    20011a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  200126:	5b                   	pop    %ebx
  200127:	5e                   	pop    %esi
  200128:	c3                   	ret    

00200129 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  200129:	57                   	push   %edi
  20012a:	56                   	push   %esi
  20012b:	53                   	push   %ebx
  20012c:	8b 44 24 10          	mov    0x10(%esp),%eax
  200130:	8b 7c 24 14          	mov    0x14(%esp),%edi
  200134:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  200138:	39 c7                	cmp    %eax,%edi
  20013a:	73 26                	jae    200162 <memmove+0x39>
  20013c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  20013f:	39 c6                	cmp    %eax,%esi
  200141:	76 1f                	jbe    200162 <memmove+0x39>
		s += n, d += n;
  200143:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  200146:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  200148:	eb 07                	jmp    200151 <memmove+0x28>
			*--d = *--s;
  20014a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  20014d:	4a                   	dec    %edx
  20014e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  200151:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  200152:	85 d2                	test   %edx,%edx
  200154:	75 f4                	jne    20014a <memmove+0x21>
  200156:	eb 10                	jmp    200168 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  200158:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  20015b:	4a                   	dec    %edx
  20015c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  20015f:	41                   	inc    %ecx
  200160:	eb 02                	jmp    200164 <memmove+0x3b>
  200162:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  200164:	85 d2                	test   %edx,%edx
  200166:	75 f0                	jne    200158 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  200168:	5b                   	pop    %ebx
  200169:	5e                   	pop    %esi
  20016a:	5f                   	pop    %edi
  20016b:	c3                   	ret    

0020016c <memset>:

void *
memset(void *v, int c, size_t n)
{
  20016c:	53                   	push   %ebx
  20016d:	8b 44 24 08          	mov    0x8(%esp),%eax
  200171:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  200175:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  200179:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  20017b:	eb 04                	jmp    200181 <memset+0x15>
		*p++ = c;
  20017d:	88 1a                	mov    %bl,(%edx)
  20017f:	49                   	dec    %ecx
  200180:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  200181:	85 c9                	test   %ecx,%ecx
  200183:	75 f8                	jne    20017d <memset+0x11>
		*p++ = c;
	return v;
}
  200185:	5b                   	pop    %ebx
  200186:	c3                   	ret    

00200187 <strlen>:

size_t
strlen(const char *s)
{
  200187:	8b 54 24 04          	mov    0x4(%esp),%edx
  20018b:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  20018d:	eb 01                	jmp    200190 <strlen+0x9>
		++n;
  20018f:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  200190:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  200194:	75 f9                	jne    20018f <strlen+0x8>
		++n;
	return n;
}
  200196:	c3                   	ret    

00200197 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  200197:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  20019b:	31 c0                	xor    %eax,%eax
  20019d:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  2001a1:	eb 01                	jmp    2001a4 <strnlen+0xd>
		++n;
  2001a3:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  2001a4:	39 d0                	cmp    %edx,%eax
  2001a6:	74 06                	je     2001ae <strnlen+0x17>
  2001a8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  2001ac:	75 f5                	jne    2001a3 <strnlen+0xc>
		++n;
	return n;
}
  2001ae:	c3                   	ret    

002001af <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  2001af:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  2001b0:	3d a0 8f 0b 00       	cmp    $0xb8fa0,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  2001b5:	53                   	push   %ebx
  2001b6:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  2001b8:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  2001bd:	0f 43 d8             	cmovae %eax,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  2001c0:	80 fa 0a             	cmp    $0xa,%dl
  2001c3:	75 2c                	jne    2001f1 <console_putc+0x42>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  2001c5:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  2001cb:	be 50 00 00 00       	mov    $0x50,%esi
  2001d0:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  2001d2:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  2001d5:	99                   	cltd   
  2001d6:	f7 fe                	idiv   %esi
  2001d8:	89 de                	mov    %ebx,%esi
  2001da:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  2001dc:	eb 07                	jmp    2001e5 <console_putc+0x36>
			*cursor++ = ' ' | color;
  2001de:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  2001e1:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  2001e2:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  2001e5:	83 f8 50             	cmp    $0x50,%eax
  2001e8:	75 f4                	jne    2001de <console_putc+0x2f>
  2001ea:	29 d0                	sub    %edx,%eax
  2001ec:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  2001ef:	eb 0b                	jmp    2001fc <console_putc+0x4d>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  2001f1:	0f b6 d2             	movzbl %dl,%edx
  2001f4:	09 ca                	or     %ecx,%edx
  2001f6:	66 89 13             	mov    %dx,(%ebx)
  2001f9:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  2001fc:	5b                   	pop    %ebx
  2001fd:	5e                   	pop    %esi
  2001fe:	c3                   	ret    

002001ff <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  2001ff:	56                   	push   %esi
  200200:	53                   	push   %ebx
  200201:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  200205:	8d 58 ff             	lea    -0x1(%eax),%ebx
  200208:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  20020c:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  200211:	75 04                	jne    200217 <fill_numbuf+0x18>
  200213:	85 d2                	test   %edx,%edx
  200215:	74 10                	je     200227 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  200217:	89 d0                	mov    %edx,%eax
  200219:	31 d2                	xor    %edx,%edx
  20021b:	f7 f1                	div    %ecx
  20021d:	4b                   	dec    %ebx
  20021e:	8a 14 16             	mov    (%esi,%edx,1),%dl
  200221:	88 13                	mov    %dl,(%ebx)
			val /= base;
  200223:	89 c2                	mov    %eax,%edx
  200225:	eb ec                	jmp    200213 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  200227:	89 d8                	mov    %ebx,%eax
  200229:	5b                   	pop    %ebx
  20022a:	5e                   	pop    %esi
  20022b:	c3                   	ret    

0020022c <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  20022c:	55                   	push   %ebp
  20022d:	57                   	push   %edi
  20022e:	56                   	push   %esi
  20022f:	53                   	push   %ebx
  200230:	83 ec 38             	sub    $0x38,%esp
  200233:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  200237:	8b 7c 24 54          	mov    0x54(%esp),%edi
  20023b:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  20023f:	e9 62 03 00 00       	jmp    2005a6 <console_vprintf+0x37a>
		if (*format != '%') {
  200244:	80 fa 25             	cmp    $0x25,%dl
  200247:	74 13                	je     20025c <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  200249:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  20024d:	0f b6 d2             	movzbl %dl,%edx
  200250:	89 f0                	mov    %esi,%eax
  200252:	e8 58 ff ff ff       	call   2001af <console_putc>
  200257:	e9 47 03 00 00       	jmp    2005a3 <console_vprintf+0x377>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  20025c:	47                   	inc    %edi
  20025d:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  200264:	00 
  200265:	eb 12                	jmp    200279 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  200267:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  200268:	8a 11                	mov    (%ecx),%dl
  20026a:	84 d2                	test   %dl,%dl
  20026c:	74 1a                	je     200288 <console_vprintf+0x5c>
  20026e:	89 e8                	mov    %ebp,%eax
  200270:	38 c2                	cmp    %al,%dl
  200272:	75 f3                	jne    200267 <console_vprintf+0x3b>
  200274:	e9 41 03 00 00       	jmp    2005ba <console_vprintf+0x38e>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  200279:	8a 17                	mov    (%edi),%dl
  20027b:	84 d2                	test   %dl,%dl
  20027d:	74 0b                	je     20028a <console_vprintf+0x5e>
  20027f:	b9 7c 06 20 00       	mov    $0x20067c,%ecx
  200284:	89 d5                	mov    %edx,%ebp
  200286:	eb e0                	jmp    200268 <console_vprintf+0x3c>
  200288:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  20028a:	8d 42 cf             	lea    -0x31(%edx),%eax
  20028d:	3c 08                	cmp    $0x8,%al
  20028f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  200296:	00 
  200297:	76 13                	jbe    2002ac <console_vprintf+0x80>
  200299:	eb 1d                	jmp    2002b8 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  20029b:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  2002a0:	0f be c0             	movsbl %al,%eax
  2002a3:	47                   	inc    %edi
  2002a4:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  2002a8:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  2002ac:	8a 07                	mov    (%edi),%al
  2002ae:	8d 50 d0             	lea    -0x30(%eax),%edx
  2002b1:	80 fa 09             	cmp    $0x9,%dl
  2002b4:	76 e5                	jbe    20029b <console_vprintf+0x6f>
  2002b6:	eb 18                	jmp    2002d0 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  2002b8:	80 fa 2a             	cmp    $0x2a,%dl
  2002bb:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  2002c2:	ff 
  2002c3:	75 0b                	jne    2002d0 <console_vprintf+0xa4>
			width = va_arg(val, int);
  2002c5:	83 c3 04             	add    $0x4,%ebx
			++format;
  2002c8:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  2002c9:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2002cc:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  2002d0:	83 cd ff             	or     $0xffffffff,%ebp
  2002d3:	80 3f 2e             	cmpb   $0x2e,(%edi)
  2002d6:	75 37                	jne    20030f <console_vprintf+0xe3>
			++format;
  2002d8:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  2002d9:	31 ed                	xor    %ebp,%ebp
  2002db:	8a 07                	mov    (%edi),%al
  2002dd:	8d 50 d0             	lea    -0x30(%eax),%edx
  2002e0:	80 fa 09             	cmp    $0x9,%dl
  2002e3:	76 0d                	jbe    2002f2 <console_vprintf+0xc6>
  2002e5:	eb 17                	jmp    2002fe <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  2002e7:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  2002ea:	0f be c0             	movsbl %al,%eax
  2002ed:	47                   	inc    %edi
  2002ee:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  2002f2:	8a 07                	mov    (%edi),%al
  2002f4:	8d 50 d0             	lea    -0x30(%eax),%edx
  2002f7:	80 fa 09             	cmp    $0x9,%dl
  2002fa:	76 eb                	jbe    2002e7 <console_vprintf+0xbb>
  2002fc:	eb 11                	jmp    20030f <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  2002fe:	3c 2a                	cmp    $0x2a,%al
  200300:	75 0b                	jne    20030d <console_vprintf+0xe1>
				precision = va_arg(val, int);
  200302:	83 c3 04             	add    $0x4,%ebx
				++format;
  200305:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  200306:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  200309:	85 ed                	test   %ebp,%ebp
  20030b:	79 02                	jns    20030f <console_vprintf+0xe3>
  20030d:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  20030f:	8a 07                	mov    (%edi),%al
  200311:	3c 64                	cmp    $0x64,%al
  200313:	74 34                	je     200349 <console_vprintf+0x11d>
  200315:	7f 1d                	jg     200334 <console_vprintf+0x108>
  200317:	3c 58                	cmp    $0x58,%al
  200319:	0f 84 a2 00 00 00    	je     2003c1 <console_vprintf+0x195>
  20031f:	3c 63                	cmp    $0x63,%al
  200321:	0f 84 bf 00 00 00    	je     2003e6 <console_vprintf+0x1ba>
  200327:	3c 43                	cmp    $0x43,%al
  200329:	0f 85 d0 00 00 00    	jne    2003ff <console_vprintf+0x1d3>
  20032f:	e9 a3 00 00 00       	jmp    2003d7 <console_vprintf+0x1ab>
  200334:	3c 75                	cmp    $0x75,%al
  200336:	74 4d                	je     200385 <console_vprintf+0x159>
  200338:	3c 78                	cmp    $0x78,%al
  20033a:	74 5c                	je     200398 <console_vprintf+0x16c>
  20033c:	3c 73                	cmp    $0x73,%al
  20033e:	0f 85 bb 00 00 00    	jne    2003ff <console_vprintf+0x1d3>
  200344:	e9 86 00 00 00       	jmp    2003cf <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  200349:	83 c3 04             	add    $0x4,%ebx
  20034c:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  20034f:	89 d1                	mov    %edx,%ecx
  200351:	c1 f9 1f             	sar    $0x1f,%ecx
  200354:	89 0c 24             	mov    %ecx,(%esp)
  200357:	31 ca                	xor    %ecx,%edx
  200359:	55                   	push   %ebp
  20035a:	29 ca                	sub    %ecx,%edx
  20035c:	68 84 06 20 00       	push   $0x200684
  200361:	b9 0a 00 00 00       	mov    $0xa,%ecx
  200366:	8d 44 24 40          	lea    0x40(%esp),%eax
  20036a:	e8 90 fe ff ff       	call   2001ff <fill_numbuf>
  20036f:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  200373:	58                   	pop    %eax
  200374:	5a                   	pop    %edx
  200375:	ba 01 00 00 00       	mov    $0x1,%edx
  20037a:	8b 04 24             	mov    (%esp),%eax
  20037d:	83 e0 01             	and    $0x1,%eax
  200380:	e9 a6 00 00 00       	jmp    20042b <console_vprintf+0x1ff>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  200385:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  200388:	b9 0a 00 00 00       	mov    $0xa,%ecx
  20038d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  200390:	55                   	push   %ebp
  200391:	68 84 06 20 00       	push   $0x200684
  200396:	eb 11                	jmp    2003a9 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  200398:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  20039b:	8b 53 fc             	mov    -0x4(%ebx),%edx
  20039e:	55                   	push   %ebp
  20039f:	68 98 06 20 00       	push   $0x200698
  2003a4:	b9 10 00 00 00       	mov    $0x10,%ecx
  2003a9:	8d 44 24 40          	lea    0x40(%esp),%eax
  2003ad:	e8 4d fe ff ff       	call   2001ff <fill_numbuf>
  2003b2:	ba 01 00 00 00       	mov    $0x1,%edx
  2003b7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2003bb:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  2003bd:	59                   	pop    %ecx
  2003be:	59                   	pop    %ecx
  2003bf:	eb 6a                	jmp    20042b <console_vprintf+0x1ff>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  2003c1:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  2003c4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003c7:	55                   	push   %ebp
  2003c8:	68 84 06 20 00       	push   $0x200684
  2003cd:	eb d5                	jmp    2003a4 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  2003cf:	83 c3 04             	add    $0x4,%ebx
  2003d2:	8b 43 fc             	mov    -0x4(%ebx),%eax
  2003d5:	eb 41                	jmp    200418 <console_vprintf+0x1ec>
			break;
		case 'C':
			color = va_arg(val, int);
  2003d7:	83 c3 04             	add    $0x4,%ebx
  2003da:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003dd:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  2003e1:	e9 bf 01 00 00       	jmp    2005a5 <console_vprintf+0x379>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  2003e6:	83 c3 04             	add    $0x4,%ebx
  2003e9:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  2003ec:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  2003f0:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  2003f5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  2003f9:	88 44 24 24          	mov    %al,0x24(%esp)
  2003fd:	eb 28                	jmp    200427 <console_vprintf+0x1fb>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  2003ff:	84 c0                	test   %al,%al
  200401:	b2 25                	mov    $0x25,%dl
  200403:	0f 44 c2             	cmove  %edx,%eax
  200406:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  20040a:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  20040f:	80 3f 00             	cmpb   $0x0,(%edi)
  200412:	74 0a                	je     20041e <console_vprintf+0x1f2>
  200414:	8d 44 24 24          	lea    0x24(%esp),%eax
  200418:	89 44 24 04          	mov    %eax,0x4(%esp)
  20041c:	eb 09                	jmp    200427 <console_vprintf+0x1fb>
				format--;
  20041e:	8d 54 24 24          	lea    0x24(%esp),%edx
  200422:	4f                   	dec    %edi
  200423:	89 54 24 04          	mov    %edx,0x4(%esp)
  200427:	31 d2                	xor    %edx,%edx
  200429:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  20042b:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  20042d:	83 fd ff             	cmp    $0xffffffff,%ebp
  200430:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  200437:	74 1f                	je     200458 <console_vprintf+0x22c>
  200439:	89 04 24             	mov    %eax,(%esp)
  20043c:	eb 01                	jmp    20043f <console_vprintf+0x213>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  20043e:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  20043f:	39 e9                	cmp    %ebp,%ecx
  200441:	74 0a                	je     20044d <console_vprintf+0x221>
  200443:	8b 44 24 04          	mov    0x4(%esp),%eax
  200447:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  20044b:	75 f1                	jne    20043e <console_vprintf+0x212>
  20044d:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  200450:	89 0c 24             	mov    %ecx,(%esp)
  200453:	eb 1f                	jmp    200474 <console_vprintf+0x248>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  200455:	42                   	inc    %edx
  200456:	eb 09                	jmp    200461 <console_vprintf+0x235>
  200458:	89 d1                	mov    %edx,%ecx
  20045a:	8b 14 24             	mov    (%esp),%edx
  20045d:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  200461:	8b 44 24 04          	mov    0x4(%esp),%eax
  200465:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  200469:	75 ea                	jne    200455 <console_vprintf+0x229>
  20046b:	8b 44 24 08          	mov    0x8(%esp),%eax
  20046f:	89 14 24             	mov    %edx,(%esp)
  200472:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  200474:	85 c0                	test   %eax,%eax
  200476:	74 0c                	je     200484 <console_vprintf+0x258>
  200478:	84 d2                	test   %dl,%dl
  20047a:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  200481:	00 
  200482:	75 24                	jne    2004a8 <console_vprintf+0x27c>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  200484:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  200489:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  200490:	00 
  200491:	75 15                	jne    2004a8 <console_vprintf+0x27c>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  200493:	8b 44 24 14          	mov    0x14(%esp),%eax
  200497:	83 e0 08             	and    $0x8,%eax
  20049a:	83 f8 01             	cmp    $0x1,%eax
  20049d:	19 c9                	sbb    %ecx,%ecx
  20049f:	f7 d1                	not    %ecx
  2004a1:	83 e1 20             	and    $0x20,%ecx
  2004a4:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  2004a8:	3b 2c 24             	cmp    (%esp),%ebp
  2004ab:	7e 0d                	jle    2004ba <console_vprintf+0x28e>
  2004ad:	84 d2                	test   %dl,%dl
  2004af:	74 41                	je     2004f2 <console_vprintf+0x2c6>
			zeros = precision - len;
  2004b1:	2b 2c 24             	sub    (%esp),%ebp
  2004b4:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  2004b8:	eb 40                	jmp    2004fa <console_vprintf+0x2ce>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004ba:	84 d2                	test   %dl,%dl
  2004bc:	74 34                	je     2004f2 <console_vprintf+0x2c6>
  2004be:	8b 44 24 14          	mov    0x14(%esp),%eax
  2004c2:	83 e0 06             	and    $0x6,%eax
  2004c5:	83 f8 02             	cmp    $0x2,%eax
  2004c8:	75 28                	jne    2004f2 <console_vprintf+0x2c6>
  2004ca:	45                   	inc    %ebp
  2004cb:	75 25                	jne    2004f2 <console_vprintf+0x2c6>
			 && numeric && precision < 0
			 && len + !!negative < width)
  2004cd:	31 c0                	xor    %eax,%eax
  2004cf:	8b 14 24             	mov    (%esp),%edx
  2004d2:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  2004d7:	0f 95 c0             	setne  %al
  2004da:	8d 14 10             	lea    (%eax,%edx,1),%edx
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004dd:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  2004e1:	7d 0f                	jge    2004f2 <console_vprintf+0x2c6>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  2004e3:	8b 54 24 0c          	mov    0xc(%esp),%edx
  2004e7:	2b 14 24             	sub    (%esp),%edx
  2004ea:	29 c2                	sub    %eax,%edx
  2004ec:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004f0:	eb 08                	jmp    2004fa <console_vprintf+0x2ce>
  2004f2:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  2004f9:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  2004fa:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  2004fe:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  200500:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  200504:	2b 2c 24             	sub    (%esp),%ebp
  200507:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  20050c:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  20050f:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  200512:	29 c5                	sub    %eax,%ebp
  200514:	89 f0                	mov    %esi,%eax
  200516:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  20051a:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  20051e:	eb 0f                	jmp    20052f <console_vprintf+0x303>
			cursor = console_putc(cursor, ' ', color);
  200520:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200524:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  200529:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  20052a:	e8 80 fc ff ff       	call   2001af <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  20052f:	85 ed                	test   %ebp,%ebp
  200531:	7e 07                	jle    20053a <console_vprintf+0x30e>
  200533:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  200538:	74 e6                	je     200520 <console_vprintf+0x2f4>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  20053a:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  20053f:	89 c6                	mov    %eax,%esi
  200541:	74 23                	je     200566 <console_vprintf+0x33a>
			cursor = console_putc(cursor, negative, color);
  200543:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  200548:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  20054c:	e8 5e fc ff ff       	call   2001af <console_putc>
  200551:	89 c6                	mov    %eax,%esi
  200553:	eb 11                	jmp    200566 <console_vprintf+0x33a>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  200555:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200559:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  20055e:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  20055f:	e8 4b fc ff ff       	call   2001af <console_putc>
  200564:	eb 06                	jmp    20056c <console_vprintf+0x340>
  200566:	89 f0                	mov    %esi,%eax
  200568:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  20056c:	85 f6                	test   %esi,%esi
  20056e:	7f e5                	jg     200555 <console_vprintf+0x329>
  200570:	8b 34 24             	mov    (%esp),%esi
  200573:	eb 15                	jmp    20058a <console_vprintf+0x35e>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  200575:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  200579:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  20057a:	0f b6 11             	movzbl (%ecx),%edx
  20057d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200581:	e8 29 fc ff ff       	call   2001af <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  200586:	ff 44 24 04          	incl   0x4(%esp)
  20058a:	85 f6                	test   %esi,%esi
  20058c:	7f e7                	jg     200575 <console_vprintf+0x349>
  20058e:	eb 0f                	jmp    20059f <console_vprintf+0x373>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  200590:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200594:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  200599:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  20059a:	e8 10 fc ff ff       	call   2001af <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  20059f:	85 ed                	test   %ebp,%ebp
  2005a1:	7f ed                	jg     200590 <console_vprintf+0x364>
  2005a3:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  2005a5:	47                   	inc    %edi
  2005a6:	8a 17                	mov    (%edi),%dl
  2005a8:	84 d2                	test   %dl,%dl
  2005aa:	0f 85 94 fc ff ff    	jne    200244 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  2005b0:	83 c4 38             	add    $0x38,%esp
  2005b3:	89 f0                	mov    %esi,%eax
  2005b5:	5b                   	pop    %ebx
  2005b6:	5e                   	pop    %esi
  2005b7:	5f                   	pop    %edi
  2005b8:	5d                   	pop    %ebp
  2005b9:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  2005ba:	81 e9 7c 06 20 00    	sub    $0x20067c,%ecx
  2005c0:	b8 01 00 00 00       	mov    $0x1,%eax
  2005c5:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  2005c7:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  2005c8:	09 44 24 14          	or     %eax,0x14(%esp)
  2005cc:	e9 a8 fc ff ff       	jmp    200279 <console_vprintf+0x4d>

002005d1 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  2005d1:	8d 44 24 10          	lea    0x10(%esp),%eax
  2005d5:	50                   	push   %eax
  2005d6:	ff 74 24 10          	pushl  0x10(%esp)
  2005da:	ff 74 24 10          	pushl  0x10(%esp)
  2005de:	ff 74 24 10          	pushl  0x10(%esp)
  2005e2:	e8 45 fc ff ff       	call   20022c <console_vprintf>
  2005e7:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  2005ea:	c3                   	ret    
