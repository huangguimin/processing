

--**************�ⶨ�塢 ������******************** 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--entity nr 1 ddastatc is  --��һ������Բ��
--******************ʵ�嶨��***********************  
entity dda is
port 
	(
	 clk		:in std_logic;
	 rst		:in std_logic;
	 start		:in std_logic;
	 Jvx		:in std_logic_vector(23 downto 0 );--���ƹ�񻯺��X����ֵ
	 Jvy		:in std_logic_vector(23 downto 0 );--���ƹ�񻯺��Y����ֵ
	 Total_Cnt	:in std_logic_vector(23 downto 0 );--����������
	 zuoyicishu	:in std_logic_vector(23 downto 0 );--���ƶ�����
	 busy		:out std_logic;
	 outx_pl	:out std_logic; --x�������
	 outy_pl	:out std_logic --y�������
	);
end entity dda;
 --******************�����嶨��*********************   
architecture  behace of  dda is
type adder_state is (Plsout_STH, Plsout_STL, Idle_ST); --������״̬���Ķ���
	signal addstate : adder_state;
	signal JRx_sub : std_logic_vector (24 downto 0); --x ���ۼ���
	signal JRy_sub : std_logic_vector (24 downto 0); --y ���ۼ���
	signal Jvx_sub : std_logic_vector (23 downto 0); --x �ᱻ�������Ĵ���
	signal Jvy_sub : std_logic_vector (23 downto 0); --y �ᱻ�������Ĵ���
	signal Total_Cnt_sub : std_logic_vector (23 downto 0); --�����������Ĵ���
begin

 --*********************����************************
process (clk,Jvx,Jvy,rst)is
	variable Total_Cut_sub : std_logic_vector(23 downto 0); --�����������Ĵ���

	begin
		if (rst = '1') then
			addstate <= Idle_ST; --״̬��λ
			outx_pl <= '0'; --���x ��������
			outy_pl <= '0'; --���y ��������
		elsif clk'event and clk = '0' then 
		case addstate is
		 when Idle_ST =>
			if (start = '1') then 
			JRx_sub <= '0'&x"800000"; --�ۼ���x �ð��س�ֵ
			JRy_sub <= '0'&x"800000"; --�ۼ���y �ð��س�ֵ
			Jvx_sub <= Jvy;
			Jvy_sub <= Jvx;
			Total_Cnt_sub <= Total_Cnt;
			busy <= '1'; --set the busy flag  --�ù���æ�ź�
			addstate <= Plsout_STH;
	end if;
	when Plsout_STH =>
		JRx_sub <= JRx_sub + Jvx_sub;
		JRy_sub <= JRy_sub + Jvy_sub;
		if Total_Cnt_sub /= x"0000000" then
					if JRx_sub (24)= '1' then
						OUTx_PL <= '1';
						JRx_sub (24)<= '0';
						Jvy_sub <= Jvy_sub - x"fffff"; --��������y �Ĵ���ֵ����
						Total_Cnt_sub<=Total_Cnt_sub- '1';
					end if;
				if JRy_sub (24)= '1' then
					OUTy_PL <= '1';
					JRy_sub (24)<= '0';
					Jvx_sub <= Jvx_sub + x"fffff";--��������x �Ĵ���ֵ����
					Total_Cnt_sub <= Total_Cnt_sub- '1';
				end if;
		end if;
	addstate <= Plsout_STL;
	when Plsout_STL =>
		if Total_Cnt_sub /= x"000000" then
			ADDstate <= Plsout_STH;
		else
		busy <= '0';--�幤��æ�ź�
	addstate <= Idle_ST;--�������״̬��λ
end if;
outx_pl <= '0';
outy_pl <= '0';
end case;
end if;
end process;
end behace;
