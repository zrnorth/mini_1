
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
  200017:	0f b6 92 88 06 20 00 	movzbl 0x200688(%edx),%edx
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
  200031:	e8 06 02 00 00       	call   20023c <console_vprintf>
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
  20004d:	68 fc 05 20 00       	push   $0x2005fc
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
  20006c:	56                   	push   %esi
  20006d:	53                   	push   %ebx
  20006e:	83 ec 20             	sub    $0x20,%esp
	volatile int checker = 0; /* This variable checks that you correctly
  200071:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  200078:	00 
				     gave the child process a new stack. */
	pid_t p;
	int status;

	app_printf("About to start a new process...\n");
  200079:	68 0f 06 20 00       	push   $0x20060f
  20007e:	e8 7d ff ff ff       	call   200000 <app_printf>
sys_fork(void)
{
	// This system call follows the same pattern as sys_getpid().

	pid_t result;
	asm volatile("int %1\n"
  200083:	cd 31                	int    $0x31

	p = sys_fork();
	if (p == 0)
  200085:	83 c4 10             	add    $0x10,%esp
  200088:	83 f8 00             	cmp    $0x0,%eax
  20008b:	89 c3                	mov    %eax,%ebx
  20008d:	75 0a                	jne    200099 <start+0x2d>

	} else {
		app_printf("Error!\n");
		sys_exit(1);
	}
}
  20008f:	83 c4 14             	add    $0x14,%esp
  200092:	5b                   	pop    %ebx
  200093:	5e                   	pop    %esi

	app_printf("About to start a new process...\n");

	p = sys_fork();
	if (p == 0)
		run_child();
  200094:	e9 a6 ff ff ff       	jmp    20003f <run_child>
	else if (p > 0) {
  200099:	7e 64                	jle    2000ff <start+0x93>
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  20009b:	cd 30                	int    $0x30
		app_printf("Main process %d!\n", sys_getpid());
  20009d:	52                   	push   %edx
  20009e:	52                   	push   %edx
  20009f:	50                   	push   %eax
  2000a0:	68 30 06 20 00       	push   $0x200630
  2000a5:	e8 56 ff ff ff       	call   200000 <app_printf>
  2000aa:	83 c4 10             	add    $0x10,%esp

static inline int
sys_wait(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  2000ad:	89 d8                	mov    %ebx,%eax
  2000af:	cd 34                	int    $0x34
		do {
			status = sys_wait(p);
            app_printf("W");
  2000b1:	83 ec 0c             	sub    $0xc,%esp
  2000b4:	89 c6                	mov    %eax,%esi
  2000b6:	68 42 06 20 00       	push   $0x200642
  2000bb:	e8 40 ff ff ff       	call   200000 <app_printf>
		} while (status == WAIT_TRYAGAIN);
  2000c0:	83 c4 10             	add    $0x10,%esp
  2000c3:	83 fe fe             	cmp    $0xfffffffe,%esi
  2000c6:	74 e5                	je     2000ad <start+0x41>
		app_printf("Child %d exited with status %d!\n", p, status);
  2000c8:	50                   	push   %eax
  2000c9:	56                   	push   %esi
  2000ca:	53                   	push   %ebx
  2000cb:	68 44 06 20 00       	push   $0x200644
  2000d0:	e8 2b ff ff ff       	call   200000 <app_printf>

		// Check whether the child process corrupted our stack.
		// (This check doesn't find all errors, but it helps.)
		if (checker != 0) {
  2000d5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2000d9:	83 c4 10             	add    $0x10,%esp
  2000dc:	85 c0                	test   %eax,%eax
  2000de:	74 19                	je     2000f9 <start+0x8d>
			app_printf("Error: stack collision!\n");
  2000e0:	83 ec 0c             	sub    $0xc,%esp
  2000e3:	68 65 06 20 00       	push   $0x200665
  2000e8:	e8 13 ff ff ff       	call   200000 <app_printf>
	// the 'int' instruction.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  2000ed:	b8 01 00 00 00       	mov    $0x1,%eax
  2000f2:	cd 33                	int    $0x33
  2000f4:	83 c4 10             	add    $0x10,%esp
  2000f7:	eb fe                	jmp    2000f7 <start+0x8b>
  2000f9:	31 c0                	xor    %eax,%eax
  2000fb:	cd 33                	int    $0x33
  2000fd:	eb fe                	jmp    2000fd <start+0x91>
			sys_exit(1);
		} else
			sys_exit(0);

	} else {
		app_printf("Error!\n");
  2000ff:	83 ec 0c             	sub    $0xc,%esp
  200102:	68 7e 06 20 00       	push   $0x20067e
  200107:	e8 f4 fe ff ff       	call   200000 <app_printf>
  20010c:	b8 01 00 00 00       	mov    $0x1,%eax
  200111:	cd 33                	int    $0x33
  200113:	83 c4 10             	add    $0x10,%esp
  200116:	eb fe                	jmp    200116 <start+0xaa>

00200118 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  200118:	56                   	push   %esi
  200119:	31 d2                	xor    %edx,%edx
  20011b:	53                   	push   %ebx
  20011c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200120:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  200124:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  200128:	eb 08                	jmp    200132 <memcpy+0x1a>
		*d++ = *s++;
  20012a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  20012d:	4e                   	dec    %esi
  20012e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  200131:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  200132:	85 f6                	test   %esi,%esi
  200134:	75 f4                	jne    20012a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  200136:	5b                   	pop    %ebx
  200137:	5e                   	pop    %esi
  200138:	c3                   	ret    

00200139 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  200139:	57                   	push   %edi
  20013a:	56                   	push   %esi
  20013b:	53                   	push   %ebx
  20013c:	8b 44 24 10          	mov    0x10(%esp),%eax
  200140:	8b 7c 24 14          	mov    0x14(%esp),%edi
  200144:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  200148:	39 c7                	cmp    %eax,%edi
  20014a:	73 26                	jae    200172 <memmove+0x39>
  20014c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  20014f:	39 c6                	cmp    %eax,%esi
  200151:	76 1f                	jbe    200172 <memmove+0x39>
		s += n, d += n;
  200153:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  200156:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  200158:	eb 07                	jmp    200161 <memmove+0x28>
			*--d = *--s;
  20015a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  20015d:	4a                   	dec    %edx
  20015e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  200161:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  200162:	85 d2                	test   %edx,%edx
  200164:	75 f4                	jne    20015a <memmove+0x21>
  200166:	eb 10                	jmp    200178 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  200168:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  20016b:	4a                   	dec    %edx
  20016c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  20016f:	41                   	inc    %ecx
  200170:	eb 02                	jmp    200174 <memmove+0x3b>
  200172:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  200174:	85 d2                	test   %edx,%edx
  200176:	75 f0                	jne    200168 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  200178:	5b                   	pop    %ebx
  200179:	5e                   	pop    %esi
  20017a:	5f                   	pop    %edi
  20017b:	c3                   	ret    

0020017c <memset>:

void *
memset(void *v, int c, size_t n)
{
  20017c:	53                   	push   %ebx
  20017d:	8b 44 24 08          	mov    0x8(%esp),%eax
  200181:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  200185:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  200189:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  20018b:	eb 04                	jmp    200191 <memset+0x15>
		*p++ = c;
  20018d:	88 1a                	mov    %bl,(%edx)
  20018f:	49                   	dec    %ecx
  200190:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  200191:	85 c9                	test   %ecx,%ecx
  200193:	75 f8                	jne    20018d <memset+0x11>
		*p++ = c;
	return v;
}
  200195:	5b                   	pop    %ebx
  200196:	c3                   	ret    

00200197 <strlen>:

size_t
strlen(const char *s)
{
  200197:	8b 54 24 04          	mov    0x4(%esp),%edx
  20019b:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  20019d:	eb 01                	jmp    2001a0 <strlen+0x9>
		++n;
  20019f:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  2001a0:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  2001a4:	75 f9                	jne    20019f <strlen+0x8>
		++n;
	return n;
}
  2001a6:	c3                   	ret    

002001a7 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  2001a7:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  2001ab:	31 c0                	xor    %eax,%eax
  2001ad:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  2001b1:	eb 01                	jmp    2001b4 <strnlen+0xd>
		++n;
  2001b3:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  2001b4:	39 d0                	cmp    %edx,%eax
  2001b6:	74 06                	je     2001be <strnlen+0x17>
  2001b8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  2001bc:	75 f5                	jne    2001b3 <strnlen+0xc>
		++n;
	return n;
}
  2001be:	c3                   	ret    

002001bf <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  2001bf:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  2001c0:	3d a0 8f 0b 00       	cmp    $0xb8fa0,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  2001c5:	53                   	push   %ebx
  2001c6:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  2001c8:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  2001cd:	0f 43 d8             	cmovae %eax,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  2001d0:	80 fa 0a             	cmp    $0xa,%dl
  2001d3:	75 2c                	jne    200201 <console_putc+0x42>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  2001d5:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  2001db:	be 50 00 00 00       	mov    $0x50,%esi
  2001e0:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  2001e2:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  2001e5:	99                   	cltd   
  2001e6:	f7 fe                	idiv   %esi
  2001e8:	89 de                	mov    %ebx,%esi
  2001ea:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  2001ec:	eb 07                	jmp    2001f5 <console_putc+0x36>
			*cursor++ = ' ' | color;
  2001ee:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  2001f1:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  2001f2:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  2001f5:	83 f8 50             	cmp    $0x50,%eax
  2001f8:	75 f4                	jne    2001ee <console_putc+0x2f>
  2001fa:	29 d0                	sub    %edx,%eax
  2001fc:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  2001ff:	eb 0b                	jmp    20020c <console_putc+0x4d>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  200201:	0f b6 d2             	movzbl %dl,%edx
  200204:	09 ca                	or     %ecx,%edx
  200206:	66 89 13             	mov    %dx,(%ebx)
  200209:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  20020c:	5b                   	pop    %ebx
  20020d:	5e                   	pop    %esi
  20020e:	c3                   	ret    

0020020f <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  20020f:	56                   	push   %esi
  200210:	53                   	push   %ebx
  200211:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  200215:	8d 58 ff             	lea    -0x1(%eax),%ebx
  200218:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  20021c:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  200221:	75 04                	jne    200227 <fill_numbuf+0x18>
  200223:	85 d2                	test   %edx,%edx
  200225:	74 10                	je     200237 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  200227:	89 d0                	mov    %edx,%eax
  200229:	31 d2                	xor    %edx,%edx
  20022b:	f7 f1                	div    %ecx
  20022d:	4b                   	dec    %ebx
  20022e:	8a 14 16             	mov    (%esi,%edx,1),%dl
  200231:	88 13                	mov    %dl,(%ebx)
			val /= base;
  200233:	89 c2                	mov    %eax,%edx
  200235:	eb ec                	jmp    200223 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  200237:	89 d8                	mov    %ebx,%eax
  200239:	5b                   	pop    %ebx
  20023a:	5e                   	pop    %esi
  20023b:	c3                   	ret    

0020023c <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  20023c:	55                   	push   %ebp
  20023d:	57                   	push   %edi
  20023e:	56                   	push   %esi
  20023f:	53                   	push   %ebx
  200240:	83 ec 38             	sub    $0x38,%esp
  200243:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  200247:	8b 7c 24 54          	mov    0x54(%esp),%edi
  20024b:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  20024f:	e9 62 03 00 00       	jmp    2005b6 <console_vprintf+0x37a>
		if (*format != '%') {
  200254:	80 fa 25             	cmp    $0x25,%dl
  200257:	74 13                	je     20026c <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  200259:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  20025d:	0f b6 d2             	movzbl %dl,%edx
  200260:	89 f0                	mov    %esi,%eax
  200262:	e8 58 ff ff ff       	call   2001bf <console_putc>
  200267:	e9 47 03 00 00       	jmp    2005b3 <console_vprintf+0x377>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  20026c:	47                   	inc    %edi
  20026d:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  200274:	00 
  200275:	eb 12                	jmp    200289 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  200277:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  200278:	8a 11                	mov    (%ecx),%dl
  20027a:	84 d2                	test   %dl,%dl
  20027c:	74 1a                	je     200298 <console_vprintf+0x5c>
  20027e:	89 e8                	mov    %ebp,%eax
  200280:	38 c2                	cmp    %al,%dl
  200282:	75 f3                	jne    200277 <console_vprintf+0x3b>
  200284:	e9 41 03 00 00       	jmp    2005ca <console_vprintf+0x38e>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  200289:	8a 17                	mov    (%edi),%dl
  20028b:	84 d2                	test   %dl,%dl
  20028d:	74 0b                	je     20029a <console_vprintf+0x5e>
  20028f:	b9 90 06 20 00       	mov    $0x200690,%ecx
  200294:	89 d5                	mov    %edx,%ebp
  200296:	eb e0                	jmp    200278 <console_vprintf+0x3c>
  200298:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  20029a:	8d 42 cf             	lea    -0x31(%edx),%eax
  20029d:	3c 08                	cmp    $0x8,%al
  20029f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  2002a6:	00 
  2002a7:	76 13                	jbe    2002bc <console_vprintf+0x80>
  2002a9:	eb 1d                	jmp    2002c8 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  2002ab:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  2002b0:	0f be c0             	movsbl %al,%eax
  2002b3:	47                   	inc    %edi
  2002b4:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  2002b8:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  2002bc:	8a 07                	mov    (%edi),%al
  2002be:	8d 50 d0             	lea    -0x30(%eax),%edx
  2002c1:	80 fa 09             	cmp    $0x9,%dl
  2002c4:	76 e5                	jbe    2002ab <console_vprintf+0x6f>
  2002c6:	eb 18                	jmp    2002e0 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  2002c8:	80 fa 2a             	cmp    $0x2a,%dl
  2002cb:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  2002d2:	ff 
  2002d3:	75 0b                	jne    2002e0 <console_vprintf+0xa4>
			width = va_arg(val, int);
  2002d5:	83 c3 04             	add    $0x4,%ebx
			++format;
  2002d8:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  2002d9:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2002dc:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  2002e0:	83 cd ff             	or     $0xffffffff,%ebp
  2002e3:	80 3f 2e             	cmpb   $0x2e,(%edi)
  2002e6:	75 37                	jne    20031f <console_vprintf+0xe3>
			++format;
  2002e8:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  2002e9:	31 ed                	xor    %ebp,%ebp
  2002eb:	8a 07                	mov    (%edi),%al
  2002ed:	8d 50 d0             	lea    -0x30(%eax),%edx
  2002f0:	80 fa 09             	cmp    $0x9,%dl
  2002f3:	76 0d                	jbe    200302 <console_vprintf+0xc6>
  2002f5:	eb 17                	jmp    20030e <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  2002f7:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  2002fa:	0f be c0             	movsbl %al,%eax
  2002fd:	47                   	inc    %edi
  2002fe:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  200302:	8a 07                	mov    (%edi),%al
  200304:	8d 50 d0             	lea    -0x30(%eax),%edx
  200307:	80 fa 09             	cmp    $0x9,%dl
  20030a:	76 eb                	jbe    2002f7 <console_vprintf+0xbb>
  20030c:	eb 11                	jmp    20031f <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  20030e:	3c 2a                	cmp    $0x2a,%al
  200310:	75 0b                	jne    20031d <console_vprintf+0xe1>
				precision = va_arg(val, int);
  200312:	83 c3 04             	add    $0x4,%ebx
				++format;
  200315:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  200316:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  200319:	85 ed                	test   %ebp,%ebp
  20031b:	79 02                	jns    20031f <console_vprintf+0xe3>
  20031d:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  20031f:	8a 07                	mov    (%edi),%al
  200321:	3c 64                	cmp    $0x64,%al
  200323:	74 34                	je     200359 <console_vprintf+0x11d>
  200325:	7f 1d                	jg     200344 <console_vprintf+0x108>
  200327:	3c 58                	cmp    $0x58,%al
  200329:	0f 84 a2 00 00 00    	je     2003d1 <console_vprintf+0x195>
  20032f:	3c 63                	cmp    $0x63,%al
  200331:	0f 84 bf 00 00 00    	je     2003f6 <console_vprintf+0x1ba>
  200337:	3c 43                	cmp    $0x43,%al
  200339:	0f 85 d0 00 00 00    	jne    20040f <console_vprintf+0x1d3>
  20033f:	e9 a3 00 00 00       	jmp    2003e7 <console_vprintf+0x1ab>
  200344:	3c 75                	cmp    $0x75,%al
  200346:	74 4d                	je     200395 <console_vprintf+0x159>
  200348:	3c 78                	cmp    $0x78,%al
  20034a:	74 5c                	je     2003a8 <console_vprintf+0x16c>
  20034c:	3c 73                	cmp    $0x73,%al
  20034e:	0f 85 bb 00 00 00    	jne    20040f <console_vprintf+0x1d3>
  200354:	e9 86 00 00 00       	jmp    2003df <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  200359:	83 c3 04             	add    $0x4,%ebx
  20035c:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  20035f:	89 d1                	mov    %edx,%ecx
  200361:	c1 f9 1f             	sar    $0x1f,%ecx
  200364:	89 0c 24             	mov    %ecx,(%esp)
  200367:	31 ca                	xor    %ecx,%edx
  200369:	55                   	push   %ebp
  20036a:	29 ca                	sub    %ecx,%edx
  20036c:	68 98 06 20 00       	push   $0x200698
  200371:	b9 0a 00 00 00       	mov    $0xa,%ecx
  200376:	8d 44 24 40          	lea    0x40(%esp),%eax
  20037a:	e8 90 fe ff ff       	call   20020f <fill_numbuf>
  20037f:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  200383:	58                   	pop    %eax
  200384:	5a                   	pop    %edx
  200385:	ba 01 00 00 00       	mov    $0x1,%edx
  20038a:	8b 04 24             	mov    (%esp),%eax
  20038d:	83 e0 01             	and    $0x1,%eax
  200390:	e9 a6 00 00 00       	jmp    20043b <console_vprintf+0x1ff>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  200395:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  200398:	b9 0a 00 00 00       	mov    $0xa,%ecx
  20039d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003a0:	55                   	push   %ebp
  2003a1:	68 98 06 20 00       	push   $0x200698
  2003a6:	eb 11                	jmp    2003b9 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  2003a8:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  2003ab:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003ae:	55                   	push   %ebp
  2003af:	68 ac 06 20 00       	push   $0x2006ac
  2003b4:	b9 10 00 00 00       	mov    $0x10,%ecx
  2003b9:	8d 44 24 40          	lea    0x40(%esp),%eax
  2003bd:	e8 4d fe ff ff       	call   20020f <fill_numbuf>
  2003c2:	ba 01 00 00 00       	mov    $0x1,%edx
  2003c7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2003cb:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  2003cd:	59                   	pop    %ecx
  2003ce:	59                   	pop    %ecx
  2003cf:	eb 6a                	jmp    20043b <console_vprintf+0x1ff>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  2003d1:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  2003d4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003d7:	55                   	push   %ebp
  2003d8:	68 98 06 20 00       	push   $0x200698
  2003dd:	eb d5                	jmp    2003b4 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  2003df:	83 c3 04             	add    $0x4,%ebx
  2003e2:	8b 43 fc             	mov    -0x4(%ebx),%eax
  2003e5:	eb 41                	jmp    200428 <console_vprintf+0x1ec>
			break;
		case 'C':
			color = va_arg(val, int);
  2003e7:	83 c3 04             	add    $0x4,%ebx
  2003ea:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003ed:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  2003f1:	e9 bf 01 00 00       	jmp    2005b5 <console_vprintf+0x379>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  2003f6:	83 c3 04             	add    $0x4,%ebx
  2003f9:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  2003fc:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  200400:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  200405:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  200409:	88 44 24 24          	mov    %al,0x24(%esp)
  20040d:	eb 28                	jmp    200437 <console_vprintf+0x1fb>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  20040f:	84 c0                	test   %al,%al
  200411:	b2 25                	mov    $0x25,%dl
  200413:	0f 44 c2             	cmove  %edx,%eax
  200416:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  20041a:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  20041f:	80 3f 00             	cmpb   $0x0,(%edi)
  200422:	74 0a                	je     20042e <console_vprintf+0x1f2>
  200424:	8d 44 24 24          	lea    0x24(%esp),%eax
  200428:	89 44 24 04          	mov    %eax,0x4(%esp)
  20042c:	eb 09                	jmp    200437 <console_vprintf+0x1fb>
				format--;
  20042e:	8d 54 24 24          	lea    0x24(%esp),%edx
  200432:	4f                   	dec    %edi
  200433:	89 54 24 04          	mov    %edx,0x4(%esp)
  200437:	31 d2                	xor    %edx,%edx
  200439:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  20043b:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  20043d:	83 fd ff             	cmp    $0xffffffff,%ebp
  200440:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  200447:	74 1f                	je     200468 <console_vprintf+0x22c>
  200449:	89 04 24             	mov    %eax,(%esp)
  20044c:	eb 01                	jmp    20044f <console_vprintf+0x213>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  20044e:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  20044f:	39 e9                	cmp    %ebp,%ecx
  200451:	74 0a                	je     20045d <console_vprintf+0x221>
  200453:	8b 44 24 04          	mov    0x4(%esp),%eax
  200457:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  20045b:	75 f1                	jne    20044e <console_vprintf+0x212>
  20045d:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  200460:	89 0c 24             	mov    %ecx,(%esp)
  200463:	eb 1f                	jmp    200484 <console_vprintf+0x248>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  200465:	42                   	inc    %edx
  200466:	eb 09                	jmp    200471 <console_vprintf+0x235>
  200468:	89 d1                	mov    %edx,%ecx
  20046a:	8b 14 24             	mov    (%esp),%edx
  20046d:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  200471:	8b 44 24 04          	mov    0x4(%esp),%eax
  200475:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  200479:	75 ea                	jne    200465 <console_vprintf+0x229>
  20047b:	8b 44 24 08          	mov    0x8(%esp),%eax
  20047f:	89 14 24             	mov    %edx,(%esp)
  200482:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  200484:	85 c0                	test   %eax,%eax
  200486:	74 0c                	je     200494 <console_vprintf+0x258>
  200488:	84 d2                	test   %dl,%dl
  20048a:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  200491:	00 
  200492:	75 24                	jne    2004b8 <console_vprintf+0x27c>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  200494:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  200499:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  2004a0:	00 
  2004a1:	75 15                	jne    2004b8 <console_vprintf+0x27c>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  2004a3:	8b 44 24 14          	mov    0x14(%esp),%eax
  2004a7:	83 e0 08             	and    $0x8,%eax
  2004aa:	83 f8 01             	cmp    $0x1,%eax
  2004ad:	19 c9                	sbb    %ecx,%ecx
  2004af:	f7 d1                	not    %ecx
  2004b1:	83 e1 20             	and    $0x20,%ecx
  2004b4:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  2004b8:	3b 2c 24             	cmp    (%esp),%ebp
  2004bb:	7e 0d                	jle    2004ca <console_vprintf+0x28e>
  2004bd:	84 d2                	test   %dl,%dl
  2004bf:	74 41                	je     200502 <console_vprintf+0x2c6>
			zeros = precision - len;
  2004c1:	2b 2c 24             	sub    (%esp),%ebp
  2004c4:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  2004c8:	eb 40                	jmp    20050a <console_vprintf+0x2ce>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004ca:	84 d2                	test   %dl,%dl
  2004cc:	74 34                	je     200502 <console_vprintf+0x2c6>
  2004ce:	8b 44 24 14          	mov    0x14(%esp),%eax
  2004d2:	83 e0 06             	and    $0x6,%eax
  2004d5:	83 f8 02             	cmp    $0x2,%eax
  2004d8:	75 28                	jne    200502 <console_vprintf+0x2c6>
  2004da:	45                   	inc    %ebp
  2004db:	75 25                	jne    200502 <console_vprintf+0x2c6>
			 && numeric && precision < 0
			 && len + !!negative < width)
  2004dd:	31 c0                	xor    %eax,%eax
  2004df:	8b 14 24             	mov    (%esp),%edx
  2004e2:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  2004e7:	0f 95 c0             	setne  %al
  2004ea:	8d 14 10             	lea    (%eax,%edx,1),%edx
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004ed:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  2004f1:	7d 0f                	jge    200502 <console_vprintf+0x2c6>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  2004f3:	8b 54 24 0c          	mov    0xc(%esp),%edx
  2004f7:	2b 14 24             	sub    (%esp),%edx
  2004fa:	29 c2                	sub    %eax,%edx
  2004fc:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  200500:	eb 08                	jmp    20050a <console_vprintf+0x2ce>
  200502:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  200509:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  20050a:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  20050e:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  200510:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  200514:	2b 2c 24             	sub    (%esp),%ebp
  200517:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  20051c:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  20051f:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  200522:	29 c5                	sub    %eax,%ebp
  200524:	89 f0                	mov    %esi,%eax
  200526:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  20052a:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  20052e:	eb 0f                	jmp    20053f <console_vprintf+0x303>
			cursor = console_putc(cursor, ' ', color);
  200530:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200534:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  200539:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  20053a:	e8 80 fc ff ff       	call   2001bf <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  20053f:	85 ed                	test   %ebp,%ebp
  200541:	7e 07                	jle    20054a <console_vprintf+0x30e>
  200543:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  200548:	74 e6                	je     200530 <console_vprintf+0x2f4>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  20054a:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  20054f:	89 c6                	mov    %eax,%esi
  200551:	74 23                	je     200576 <console_vprintf+0x33a>
			cursor = console_putc(cursor, negative, color);
  200553:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  200558:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  20055c:	e8 5e fc ff ff       	call   2001bf <console_putc>
  200561:	89 c6                	mov    %eax,%esi
  200563:	eb 11                	jmp    200576 <console_vprintf+0x33a>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  200565:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200569:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  20056e:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  20056f:	e8 4b fc ff ff       	call   2001bf <console_putc>
  200574:	eb 06                	jmp    20057c <console_vprintf+0x340>
  200576:	89 f0                	mov    %esi,%eax
  200578:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  20057c:	85 f6                	test   %esi,%esi
  20057e:	7f e5                	jg     200565 <console_vprintf+0x329>
  200580:	8b 34 24             	mov    (%esp),%esi
  200583:	eb 15                	jmp    20059a <console_vprintf+0x35e>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  200585:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  200589:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  20058a:	0f b6 11             	movzbl (%ecx),%edx
  20058d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200591:	e8 29 fc ff ff       	call   2001bf <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  200596:	ff 44 24 04          	incl   0x4(%esp)
  20059a:	85 f6                	test   %esi,%esi
  20059c:	7f e7                	jg     200585 <console_vprintf+0x349>
  20059e:	eb 0f                	jmp    2005af <console_vprintf+0x373>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  2005a0:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  2005a4:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  2005a9:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  2005aa:	e8 10 fc ff ff       	call   2001bf <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  2005af:	85 ed                	test   %ebp,%ebp
  2005b1:	7f ed                	jg     2005a0 <console_vprintf+0x364>
  2005b3:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  2005b5:	47                   	inc    %edi
  2005b6:	8a 17                	mov    (%edi),%dl
  2005b8:	84 d2                	test   %dl,%dl
  2005ba:	0f 85 94 fc ff ff    	jne    200254 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  2005c0:	83 c4 38             	add    $0x38,%esp
  2005c3:	89 f0                	mov    %esi,%eax
  2005c5:	5b                   	pop    %ebx
  2005c6:	5e                   	pop    %esi
  2005c7:	5f                   	pop    %edi
  2005c8:	5d                   	pop    %ebp
  2005c9:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  2005ca:	81 e9 90 06 20 00    	sub    $0x200690,%ecx
  2005d0:	b8 01 00 00 00       	mov    $0x1,%eax
  2005d5:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  2005d7:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  2005d8:	09 44 24 14          	or     %eax,0x14(%esp)
  2005dc:	e9 a8 fc ff ff       	jmp    200289 <console_vprintf+0x4d>

002005e1 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  2005e1:	8d 44 24 10          	lea    0x10(%esp),%eax
  2005e5:	50                   	push   %eax
  2005e6:	ff 74 24 10          	pushl  0x10(%esp)
  2005ea:	ff 74 24 10          	pushl  0x10(%esp)
  2005ee:	ff 74 24 10          	pushl  0x10(%esp)
  2005f2:	e8 45 fc ff ff       	call   20023c <console_vprintf>
  2005f7:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  2005fa:	c3                   	ret    
