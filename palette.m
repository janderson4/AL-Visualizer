function [color] = palette(num)
%% returns a hex code for one of the 7 rainbow colors based on the number 
%% of the color input
colors=[
"#e81416",
"#ffa500",
"#E4D201",
"#00A814",
"#487de7",
"#4b369d",
"#e319be"
];
color = colors(num);
end