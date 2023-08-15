(* wolfram -script qe_test/reduce.wl *)
(* Get["qe_test/reduce.wl"] *)
(* FilePrint["qe_test/result.txt"] *)

Timing[Reduce[Exists[{x}, a*x^2 + b*x + c == 0, a != 0], {a,b,c}, Reals]] >> qe_test/result.txt
(* {0.004614, (a < 0 && c >= b^2/(4*a)) || (a > 0 && c <= b^2/(4*a))} *)

Timing[Reduce[Exists[{x}, a*x^3 + b*x^2 + c*x + d == 0,a != 0], {a,b,c,d}, Reals]] >> qe_test/result.txt
(* {0.011922, a < 0 || a > 0} *)

Timing[Reduce[Exists[{x}, a*x^4 + b*x^3 + c*x^2 + d*x + e == 0,a != 0], {a,b,c,d,e}, Reals]] >> qe_test/result.txt
(* {0.162873, 
 (a < 0 && ((c < (3*b^2)/(8*a) && ((d < (-b^3 + 4*a*b*c)/(8*a^2) && 
       e >= Root[b^2*c^2*d^2 - 4*a*c^3*d^2 - 4*b^3*d^3 + 18*a*b*c*d^3 - 
           27*a^2*d^4 + (-4*b^2*c^3 + 16*a*c^4 + 18*b^3*c*d - 80*a*b*c^2*d - 
             6*a*b^2*d^2 + 144*a^2*c*d^2)*#1 + (-27*b^4 + 144*a*b^2*c - 
             128*a^2*c^2 - 192*a^2*b*d)*#1^2 + 256*a^3*#1^3 & , 1]) || 
      (d == (-b^3 + 4*a*b*c)/(8*a^2) && 
       e >= Root[b^2*c^2*d^2 - 4*a*c^3*d^2 - 4*b^3*d^3 + 18*a*b*c*d^3 - 
           27*a^2*d^4 + (-4*b^2*c^3 + 16*a*c^4 + 18*b^3*c*d - 80*a*b*c^2*d - 
             6*a*b^2*d^2 + 144*a^2*c*d^2)*#1 + (-27*b^4 + 144*a*b^2*c - 
             128*a^2*c^2 - 192*a^2*b*d)*#1^2 + 256*a^3*#1^3 & , 3]) || 
      (d > (-b^3 + 4*a*b*c)/(8*a^2) && 
       e >= Root[b^2*c^2*d^2 - 4*a*c^3*d^2 - 4*b^3*d^3 + 18*a*b*c*d^3 - 
           27*a^2*d^4 + (-4*b^2*c^3 + 16*a*c^4 + 18*b^3*c*d - 80*a*b*c^2*d - 
             6*a*b^2*d^2 + 144*a^2*c*d^2)*#1 + (-27*b^4 + 144*a*b^2*c - 
             128*a^2*c^2 - 192*a^2*b*d)*#1^2 + 256*a^3*#1^3 & , 1]))) || 
    (c >= (3*b^2)/(8*a) && e >= Root[b^2*c^2*d^2 - 4*a*c^3*d^2 - 4*b^3*d^3 + 
         18*a*b*c*d^3 - 27*a^2*d^4 + (-4*b^2*c^3 + 16*a*c^4 + 18*b^3*c*d - 
           80*a*b*c^2*d - 6*a*b^2*d^2 + 144*a^2*c*d^2)*#1 + 
         (-27*b^4 + 144*a*b^2*c - 128*a^2*c^2 - 192*a^2*b*d)*#1^2 + 
         256*a^3*#1^3 & , 1]))) || 
  (a > 0 && ((c < (3*b^2)/(8*a) && 
     ((d < (-b^3 + 4*a*b*c)/(8*a^2) - 
         Sqrt[(27*b^6 - 216*a*b^4*c + 576*a^2*b^2*c^2 - 512*a^3*c^3)/a^4]/
          (24*Sqrt[3]) && e <= Root[b^2*c^2*d^2 - 4*a*c^3*d^2 - 4*b^3*d^3 + 
           18*a*b*c*d^3 - 27*a^2*d^4 + (-4*b^2*c^3 + 16*a*c^4 + 18*b^3*c*d - 
             80*a*b*c^2*d - 6*a*b^2*d^2 + 144*a^2*c*d^2)*#1 + 
           (-27*b^4 + 144*a*b^2*c - 128*a^2*c^2 - 192*a^2*b*d)*#1^2 + 
           256*a^3*#1^3 & , 1]) || (Inequality[(-b^3 + 4*a*b*c)/(8*a^2) - 
         Sqrt[(27*b^6 - 216*a*b^4*c + 576*a^2*b^2*c^2 - 512*a^3*c^3)/a^4]/
          (24*Sqrt[3]), LessEqual, d, Less, (-b^3 + 4*a*b*c)/(8*a^2)] && 
       e <= Root[b^2*c^2*d^2 - 4*a*c^3*d^2 - 4*b^3*d^3 + 18*a*b*c*d^3 - 
           27*a^2*d^4 + (-4*b^2*c^3 + 16*a*c^4 + 18*b^3*c*d - 80*a*b*c^2*d - 
             6*a*b^2*d^2 + 144*a^2*c*d^2)*#1 + (-27*b^4 + 144*a*b^2*c - 
             128*a^2*c^2 - 192*a^2*b*d)*#1^2 + 256*a^3*#1^3 & , 3]) || 
      (d == (-b^3 + 4*a*b*c)/(8*a^2) && 
       e <= Root[b^2*c^2*d^2 - 4*a*c^3*d^2 - 4*b^3*d^3 + 18*a*b*c*d^3 - 
           27*a^2*d^4 + (-4*b^2*c^3 + 16*a*c^4 + 18*b^3*c*d - 80*a*b*c^2*d - 
             6*a*b^2*d^2 + 144*a^2*c*d^2)*#1 + (-27*b^4 + 144*a*b^2*c - 
             128*a^2*c^2 - 192*a^2*b*d)*#1^2 + 256*a^3*#1^3 & , 2]) || 
      (Inequality[(-b^3 + 4*a*b*c)/(8*a^2), Less, d, LessEqual, 
        (-b^3 + 4*a*b*c)/(8*a^2) + Sqrt[(27*b^6 - 216*a*b^4*c + 
             576*a^2*b^2*c^2 - 512*a^3*c^3)/a^4]/(24*Sqrt[3])] && 
       e <= Root[b^2*c^2*d^2 - 4*a*c^3*d^2 - 4*b^3*d^3 + 18*a*b*c*d^3 - 
           27*a^2*d^4 + (-4*b^2*c^3 + 16*a*c^4 + 18*b^3*c*d - 80*a*b*c^2*d - 
             6*a*b^2*d^2 + 144*a^2*c*d^2)*#1 + (-27*b^4 + 144*a*b^2*c - 
             128*a^2*c^2 - 192*a^2*b*d)*#1^2 + 256*a^3*#1^3 & , 3]) || 
      (d > (-b^3 + 4*a*b*c)/(8*a^2) + 
         Sqrt[(27*b^6 - 216*a*b^4*c + 576*a^2*b^2*c^2 - 512*a^3*c^3)/a^4]/
          (24*Sqrt[3]) && e <= Root[b^2*c^2*d^2 - 4*a*c^3*d^2 - 4*b^3*d^3 + 
           18*a*b*c*d^3 - 27*a^2*d^4 + (-4*b^2*c^3 + 16*a*c^4 + 18*b^3*c*d - 
             80*a*b*c^2*d - 6*a*b^2*d^2 + 144*a^2*c*d^2)*#1 + 
           (-27*b^4 + 144*a*b^2*c - 128*a^2*c^2 - 192*a^2*b*d)*#1^2 + 
           256*a^3*#1^3 & , 1]))) || (c >= (3*b^2)/(8*a) && 
     e <= Root[b^2*c^2*d^2 - 4*a*c^3*d^2 - 4*b^3*d^3 + 18*a*b*c*d^3 - 
         27*a^2*d^4 + (-4*b^2*c^3 + 16*a*c^4 + 18*b^3*c*d - 80*a*b*c^2*d - 
           6*a*b^2*d^2 + 144*a^2*c*d^2)*#1 + (-27*b^4 + 144*a*b^2*c - 
           128*a^2*c^2 - 192*a^2*b*d)*#1^2 + 256*a^3*#1^3 & , 1])))} *)

Timing[Reduce[Exists[{x}, 2*x^2 + 4*x*y + 3*y^2 + 4*x + 5*y - 4 == 0], {y}, Reals]] >> qe_test/result.txt
(* {0.13005, Inequality[-3, LessEqual, y, LessEqual, 2]} *)

Timing[Reduce[Exists[{y}, 2*x^2 + 4*x*y + 3*y^2 + 4*x + 5*y - 4 == 0], {y}, Reals]] >> qe_test/result.txt
(* {0.00704, Inequality[(-2 - 5*Sqrt[6])/4, LessEqual, x, LessEqual, 
  (-2 + 5*Sqrt[6])/4]} *)

Timing[Reduce[Exists[{x,y}, 2*x^2 + 4*x*y + 3*y^2 + 4*x + 5*y - 4 == 0, x+y == a],{a}, Reals]] >> qe_test/result.txt
(* {0.004617, Inequality[(-4 - 5*Sqrt[2])/4, LessEqual, a, LessEqual, 
  (-4 + 5*Sqrt[2])/4]} *)

Timing[Reduce[Exists[{x,y}, x^2 + a*x*y + b*y^2 + c*x + d*y + e == 0],{a,b,c,d,e}, Reals]] >> qe_test/result.txt
(* {0.033083, b < a^2/4 || (b == a^2/4 && (d < (a*c)/2 || 
    (d == (a*c)/2 && e <= c^2/4) || d > (a*c)/2)) || 
  (b > a^2/4 && e <= (b*c^2 - a*c*d + d^2)/(-a^2 + 4*b))} *)

Timing[Reduce[Exists[{x,y}, a*x^2 + b*x*y + c*y^2 + d*x + e*y + 1 == 0],{a,b,c,d,e}, Reals]] >> qe_test/result.txt
(* {0.15012, a < 0 || (a == 0 && (b < 0 || 
    (b == 0 && (c < 0 || (c == 0 && (d < 0 || (d == 0 && (e < 0 || e > 0)) || 
        d > 0)) || (c > 0 && (d < 0 || (d == 0 && (e <= -2*Sqrt[c] || 
          e >= 2*Sqrt[c])) || d > 0)))) || b > 0)) || 
  (a > 0 && ((b < 0 && (c < b^2/(4*a) || (c == b^2/(4*a) && 
       (d <= -2*Sqrt[a] || (Inequality[-2*Sqrt[a], Less, d, Less, 
          2*Sqrt[a]] && (e < (b*d)/(2*a) + Sqrt[(-4*a*b^2 + 16*a^2*c + 
                b^2*d^2 - 4*a*c*d^2)/a^2]/2 || 
          e > (b*d)/(2*a) + Sqrt[(-4*a*b^2 + 16*a^2*c + b^2*d^2 - 4*a*c*d^2)/
               a^2]/2)) || d >= 2*Sqrt[a])) || (c > b^2/(4*a) && 
       (d <= -2*Sqrt[a] || (Inequality[-2*Sqrt[a], Less, d, Less, 
          2*Sqrt[a]] && (e <= (b*d)/(2*a) - Sqrt[(-4*a*b^2 + 16*a^2*c + 
                b^2*d^2 - 4*a*c*d^2)/a^2]/2 || e >= (b*d)/(2*a) + 
            Sqrt[(-4*a*b^2 + 16*a^2*c + b^2*d^2 - 4*a*c*d^2)/a^2]/2)) || 
        d >= 2*Sqrt[a])))) || (b == 0 && 
     (c < 0 || (c == 0 && (d <= -2*Sqrt[a] || (Inequality[-2*Sqrt[a], Less, 
          d, Less, 2*Sqrt[a]] && (e < 0 || e > 0)) || d >= 2*Sqrt[a])) || 
      (c > 0 && (d <= -2*Sqrt[a] || (Inequality[-2*Sqrt[a], Less, d, Less, 
          2*Sqrt[a]] && (e <= -Sqrt[(16*a^2*c - 4*a*c*d^2)/a^2]/2 || 
          e >= Sqrt[(16*a^2*c - 4*a*c*d^2)/a^2]/2)) || d >= 2*Sqrt[a])))) || 
    (b > 0 && (c < b^2/(4*a) || (c == b^2/(4*a) && (d <= -2*Sqrt[a] || 
        (Inequality[-2*Sqrt[a], Less, d, Less, 2*Sqrt[a]] && 
         (e < (b*d)/(2*a) + Sqrt[(-4*a*b^2 + 16*a^2*c + b^2*d^2 - 4*a*c*d^2)/
               a^2]/2 || e > (b*d)/(2*a) + Sqrt[(-4*a*b^2 + 16*a^2*c + 
                b^2*d^2 - 4*a*c*d^2)/a^2]/2)) || d >= 2*Sqrt[a])) || 
      (c > b^2/(4*a) && (d <= -2*Sqrt[a] || (Inequality[-2*Sqrt[a], Less, d, 
          Less, 2*Sqrt[a]] && (e <= (b*d)/(2*a) - 
            Sqrt[(-4*a*b^2 + 16*a^2*c + b^2*d^2 - 4*a*c*d^2)/a^2]/2 || 
          e >= (b*d)/(2*a) + Sqrt[(-4*a*b^2 + 16*a^2*c + b^2*d^2 - 4*a*c*d^2)/
               a^2]/2)) || d >= 2*Sqrt[a]))))))} *)

Timing[Reduce[Exists[{x,y}, a*x^2 + b*x*y + c*y^2 + d*x + e*y + f == 0],{a,b,c,d,e,f}, Reals]] >> qe_test/result.txt
(* {0.083136, 
 (a < 0 && ((b < 0 && ((c < b^2/(4*a) && f >= (c*d^2 - b*d*e + a*e^2)/
         (-b^2 + 4*a*c)) || (c == b^2/(4*a) && (e < (2*c*d)/b || 
        (e == (2*c*d)/b && f >= e^2/(4*c)) || e > (2*c*d)/b)) || 
      c > b^2/(4*a))) || (b == 0 && 
     ((c < 0 && f >= (c*d^2 + a*e^2)/(4*a*c)) || 
      (c == 0 && (e < 0 || (e == 0 && f >= d^2/(4*a)) || e > 0)) || 
      c > 0)) || (b > 0 && ((c < b^2/(4*a) && 
       f >= (c*d^2 - b*d*e + a*e^2)/(-b^2 + 4*a*c)) || 
      (c == b^2/(4*a) && (e < (2*c*d)/b || (e == (2*c*d)/b && 
         f >= e^2/(4*c)) || e > (2*c*d)/b)) || c > b^2/(4*a))))) || 
  (a == 0 && (b < 0 || (b == 0 && 
     ((c < 0 && (d < 0 || (d == 0 && f >= e^2/(4*c)) || d > 0)) || 
      (c == 0 && (d < 0 || (d == 0 && (e < 0 || (e == 0 && f == 0) || 
          e > 0)) || d > 0)) || (c > 0 && (d < 0 || 
        (d == 0 && f <= e^2/(4*c)) || d > 0)))) || b > 0)) || 
  (a > 0 && ((b < 0 && (c < b^2/(4*a) || (c == b^2/(4*a) && 
       (e < (2*c*d)/b || (e == (2*c*d)/b && f <= e^2/(4*c)) || 
        e > (2*c*d)/b)) || (c > b^2/(4*a) && 
       f <= (c*d^2 - b*d*e + a*e^2)/(-b^2 + 4*a*c)))) || 
    (b == 0 && (c < 0 || (c == 0 && (e < 0 || (e == 0 && f <= d^2/(4*a)) || 
        e > 0)) || (c > 0 && f <= (c*d^2 + a*e^2)/(4*a*c)))) || 
    (b > 0 && (c < b^2/(4*a) || (c == b^2/(4*a) && (e < (2*c*d)/b || 
        (e == (2*c*d)/b && f <= e^2/(4*c)) || e > (2*c*d)/b)) || 
      (c > b^2/(4*a) && f <= (c*d^2 - b*d*e + a*e^2)/(-b^2 + 4*a*c))))))} *)


Timing[Reduce[Exists[{x},x <= (a*x)^(1/2), x > 0],{a}, Reals]] >> qe_test/result.txt
(* {0.001289, a > 0} *)

Timing[Reduce[Exists[{x},x^2 <= a*x, x > 0],{a}, Reals]] >> qe_test/result.txt
(* {0.003399, a > 0} *)

Timing[Reduce[Exists[{x},(x)^(1/2) <= (x + y)^(1/2), x > 0],{y}, Reals]] >> qe_test/result.txt
(* {0.006229, y >= 0} *)

Timing[Reduce[Exists[{x},(x)^(1/2) + (y)^(1/2) <= (x + y)^(1/2), x > 0],{y}, Reals]] >> qe_test/result.txt
(* {0.007352, y == 0} *)

Timing[Reduce[Exists[{y},(x)^(1/2) + (y)^(1/2) <= (x + y)^(1/2), x > 0],{x}, Reals]] >> qe_test/result.txt
(* {0.008049, x > 0} *)

Timing[Reduce[Exists[{x,y},(x)^(1/2) + (y)^(1/2) <= a*(2*x + y)^(1/2), x > 0],{a}, Reals]] >> qe_test/result.txt
(* {0.067762, a >= 1/Sqrt[2]} *)

Timing[Reduce[Exists[{x,y},(x)^(1/2) + (y*b)^(1/2) <= a*(2*x + y)^(1/2) && x > 0 ],{a,b}, Reals]] >> qe_test/result.txt
(* {0.711805, (Inequality[0, Less, a, Less, 1/Sqrt[2]] &&  *)
   (* Inequality[0, LessEqual, b, Less, a^2]) || a >= 1/Sqrt[2]} *)

Timing[Reduce[Exists[{x,y,z},x^3 + 2*x^2*y - b*x*y*z + y^2*z - z^3 + a == 10],{a,b}, Reals]] >> qe_test/result.txt
(* {0.443553, True} *)

Timing[Reduce[Exists[{x,y,z},c*x^3 + 2*x^2*y - b*x*y*z + y^2*z - z^3 + a == 10],{a,b,c}, Reals]] >> qe_test/result.txt
(* 解けない *)

Timing[Reduce[Exists[{x,y,z},((x+y+z)^(1/2)+(x+y))^(1/2)  == (a+z)^(1/2) + b],{a,b}, Reals]] >> qe_test/result.txt
(* 解けない *)

Timing[Reduce[Exists[{x,y,z},((x+y+z)^(1/2)+(x+y))^(1/2)  == (a)^(1/2) + b],{a,b}, Reals]] >> qe_test/result.txt
(* {0.091439, a >= 0 && b >= -Sqrt[a]} *)

Timing[Reduce[Exists[{x,y,z},((x+y+z)^(1/2)+(x+y))^(1/2)  >= (a+z)^(1/2) - 1],{a}, Reals]] >> qe_test/result.txt
(* {0.515615, True} *)

Timing[Reduce[Exists[{x,y,z},((x+y+z)^(1/2)+(x^2+b))^(1/2)  <= (a+b+z^2)^(1/2)+y],{a,b}, Reals]] >> qe_test/result.txt
(* 解けない *)

