

--**************库定义、 包定义******************** 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--entity nr 1 ddastatc is  --第一象限逆圆弧
--******************实体定义***********************  
entity dda is
port 
	(
	 clk		:in std_logic;
	 rst		:in std_logic;
	 start		:in std_logic;
	 Jvx		:in std_logic_vector(23 downto 0 );--左移规格化后的X坐标值
	 Jvy		:in std_logic_vector(23 downto 0 );--左移规格化后的Y坐标值
	 Total_Cnt	:in std_logic_vector(23 downto 0 );--输出脉冲个数
	 zuoyicishu	:in std_logic_vector(23 downto 0 );--左移动次数
	 busy		:out std_logic;
	 outx_pl	:out std_logic; --x输出脉冲
	 outy_pl	:out std_logic --y输出脉冲
	);
end entity dda;
 --******************构造体定义*********************   
architecture  behace of  dda is
type adder_state is (Plsout_STH, Plsout_STL, Idle_ST); --积分器状态机的定义
	signal addstate : adder_state;
	signal JRx_sub : std_logic_vector (24 downto 0); --x 轴累加器
	signal JRy_sub : std_logic_vector (24 downto 0); --y 轴累加器
	signal Jvx_sub : std_logic_vector (23 downto 0); --x 轴被积函数寄存器
	signal Jvy_sub : std_logic_vector (23 downto 0); --y 轴被积函数寄存器
	signal Total_Cnt_sub : std_logic_vector (23 downto 0); --输出脉冲个数寄存器
begin

 --*********************进程************************
process (clk,Jvx,Jvy,rst)is
	variable Total_Cut_sub : std_logic_vector(23 downto 0); --输出脉冲个数寄存器

	begin
		if (rst = '1') then
			addstate <= Idle_ST; --状态复位
			outx_pl <= '0'; --输出x 脉冲清零
			outy_pl <= '0'; --输出y 脉冲清零
		elsif clk'event and clk = '0' then 
		case addstate is
		 when Idle_ST =>
			if (start = '1') then 
			JRx_sub <= '0'&x"800000"; --累加器x 置半载初值
			JRy_sub <= '0'&x"800000"; --累加器y 置半载初值
			Jvx_sub <= Jvy;
			Jvy_sub <= Jvx;
			Total_Cnt_sub <= Total_Cnt;
			busy <= '1'; --set the busy flag  --置工作忙信号
			addstate <= Plsout_STH;
	end if;
	when Plsout_STH =>
		JRx_sub <= JRx_sub + Jvx_sub;
		JRy_sub <= JRy_sub + Jvy_sub;
		if Total_Cnt_sub /= x"0000000" then
					if JRx_sub (24)= '1' then
						OUTx_PL <= '1';
						JRx_sub (24)<= '0';
						Jvy_sub <= Jvy_sub - x"fffff"; --被积函数y 寄存器值修正
						Total_Cnt_sub<=Total_Cnt_sub- '1';
					end if;
				if JRy_sub (24)= '1' then
					OUTy_PL <= '1';
					JRy_sub (24)<= '0';
					Jvx_sub <= Jvx_sub + x"fffff";--被积函数x 寄存器值修正
					Total_Cnt_sub <= Total_Cnt_sub- '1';
				end if;
		end if;
	addstate <= Plsout_STL;
	when Plsout_STL =>
		if Total_Cnt_sub /= x"000000" then
			ADDstate <= Plsout_STH;
		else
		busy <= '0';--清工作忙信号
	addstate <= Idle_ST;--输出结束状态复位
end if;
outx_pl <= '0';
outy_pl <= '0';
end case;
end if;
end process;
end behace;
