Visualizes steps of the Augmented Lagrangian method for 2D optimization problems.

<img src="https://github.com/user-attachments/assets/b3475d50-f7ea-4f89-b75f-517fffd8eb78" width="400">

The objective function can be changed by editing the box labeled ``f =" and the constraints can be changed by editing the x and y values of the control points under the labels ``X:" and ``Y:" or by adding and removing control points. To begin the optimization, press the ``NEXT STEP" button. 

The top center plot displays the objective function with inequality constraints indicated by colored lines and shaded regions. At each step of the AL method, the app displays a plot of the unconstrained AL subproblem at that step and the current estimates of the Lagrange multipliers. Each AL subproblem is solved using fminunc, which means MATLAB Optimization Toolbox is required. Symbolic Math Toolbox is also required. 

<img src="https://github.com/user-attachments/assets/f5541ed3-719f-4061-9ef7-47ec9f8a3bdc" width="320">

The Augmented Lagrangian algorithm used by this app is as follows:
<img src="https://github.com/user-attachments/assets/262cf58d-6fda-4818-b610-fe546a969229" width="600">
