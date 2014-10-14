package cs429;

/* instruction encoding
 * 
 * 0000 0000    halt
 * 
 * 0000 11dd    jle dd - branch to Rdd if 0 >= result reg
 * 0001 10dd    outch dd - print char value of Rdd
 * 0001 11dd    show dd - print Rdd as hex & dec
 * 0010 00dd    ldi dd - movi; move 8-bit immediate value to Rdd
 * 
 * 1000 ssdd   add ss,dd - Rdd = Rdd + Rss
 * 1011 ssdd   cmp ss,dd - Reg[resul] = Rdd - Rss 
 */

public class Simulator {

	public static boolean DEBUG = false;

	public static void debug(String msg, Object... args) {
		if (DEBUG) 
			System.out.printf(msg, args);
	}

	public static void outch(byte val) {
		System.out.printf("%c", val);
	}

	public static void show(int reg, byte val) {
		System.out.printf("reg[%d] = %d 0x%x\n", reg, val, val);
	}

	public static byte run(byte mem[]) {
		//reg[0-3] => r0-r3; reg[4] => result register
		int reg[] = new int[]{0, 0, 0, 0, 1};
		int pc = 0;
		boolean halt = false;
		
		while (pc < mem.length && !halt) {
			int op = op4(mem[pc]);
			int ss = ss(mem[pc]);
			int dd = dd(mem[pc]);
			
			switch (op) {
			case 0: 		//check - halt / invalid || jle
				if (ss < 3) 
					halt = halt();
				else if (reg[4] <= 0) 
					// jle 
					pc = reg[dd];
				else 
					pc++;
				break;
			case 1: 		//check - outch || show || invalid
				if (ss == 1 || ss == 4) 
					halt = halt();
				else if (ss == 2) {
					outch( ((byte)reg[dd]) );
					pc++;
				}
				else {
					show(dd, ((byte)reg[dd]) ); 
					pc++;
				}
				break;
			case 2: 		//movi
				if (ss > 0) 
					halt = halt();
				else {
					movi(reg, mem[pc+1], dd);
					pc+=2;
				}
				break;
			case 8: 		//add
				add(reg, ss, dd);
				pc++;
				break;
			case 11: 		//cmp
				cmp(reg, ss, dd);
				pc++;
				break;
			default: 		//invalid; halt
				halt = true;
				break;
			}
		}
		return (byte) pc;
	}

	public static boolean halt() {
		return true;
	}
	
	public static void movi(int[] reg, byte val, int dd) { 
		int intVal = byteToInt(val);
		reg[dd] = intVal;
	}

	public static void add(int[] reg, int ss, int dd) {
		reg[dd] = reg[dd] + reg[ss];
	}

	public static void cmp(int[] reg, int ss, int dd) {
		reg[4] = reg[dd] - reg[ss];
	}

	static int byteToInt(byte b) {
		return ((int) b) & 0xff;
	}
	
	static int dd(byte ins) {
		return ins & 3;
	}

	static int ss(byte ins) {
		return (ins >> 2) & 3;
	}

	static int op4(byte ins) {
		return (ins >> 4) & 0xf;
	}
}
