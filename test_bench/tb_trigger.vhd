library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_trigger is
end entity;

architecture rtl of tb_trigger is
constant CLK_PER : time := 20 ns;
signal clk, d : std_logic := '0';
begin

    clk <= not clk after CLK_PER / 2;

      u_trigger_inst : entity work.trigger
      port map (
        freq_vent_i => d,
        clk_i => clk,
        bool_trigger_o => open
      );
    
      process
      begin
        d <= '0'; wait for 2*CLK_PER;
        d <= '1'; wait for 2*CLK_PER;
        d <= '0'; wait for 2*CLK_PER;
        d <= '1'; wait for CLK_PER;
        d <= '0'; wait for CLK_PER;
      end process;
end architecture;
