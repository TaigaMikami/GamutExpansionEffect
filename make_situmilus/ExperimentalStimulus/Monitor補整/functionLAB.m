%% CIE‹Ï“™F‹óŠÔ-ğŒ•ªŠò

function y = functionLAB(x)

if x >= 0.008856
  y = x.^(1/3);
else
  y = 7.787.*x+(16./116);
end