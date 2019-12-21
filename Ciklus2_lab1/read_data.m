function [s] = read_data(name)
  s = load(name);
  temp = s';
  s = temp(:);