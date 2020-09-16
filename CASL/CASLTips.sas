cas mysess;
libname mylib cas sessref=mysess;

/* links
https://support.sas.com/documentation/onlinedoc/vs/index.html

http://documentation.sas.com/?cdcId=pgmsascdc&cdcVersion=9.4_3.4&docsetId=casstat&docsetTarget=casstat_regselect_overview02.htm&locale=en

http://documentation.sas.com/?cdcId=pgmsascdc&cdcVersion=9.4_3.4&docsetId=casactstat&docsetTarget=casactstat_glm_syntax.htm&locale=en
*/

/*****************************************************/
/*  Simulate data                                    */
/*****************************************************/
/*
y=score
g=evaluator
x1=flour
x2=salt
x3=yeast
x4=mix1
x5=mix2
x6=water1
x7=water2
x8=water
x9=prove
x10=rest
x11=bake
x12=amb
A=Amt
T=Time
S=Speed
E=Temp
H=Humidity
L1=EasyA
L2=GrumpyB
*/
data mylib.mytable  / single=no;
   call streaminit(1);
   length g $7;
   drop i s t xbeta;

   do i=1 to 1000;
      xBeta=0;
      x1A        = 500+10*rand('normal');
      t = (x1A-500); if t>0 then s=.3*t; else s=-0.3*t; xBeta + s;
      x2A         =   8+int(rand('uniform')*4);
      t = (x2A-10); if t>0 then s=2*t/2; else s=-0.5*t/2; xBeta + s;
      x3A        =   8+int(rand('uniform')*4);
      t = (x3A-10); if t>0 then s=5*t/2; else s=-5*t/2; xBeta + s;
      x4T        =   5+rand('normal');
      t = (x4T-5); if t>0 then s=2*t; else s=-2*t; xBeta + s;
      x4S       =   2+int(rand('uniform')*3);
      t =(x4S-3.5); if t>0 then s=0.1*t/1.5; else s=-0.1*t/1.5; xBeta + s;
      x5T        =   4+int(rand('uniform')*4);
      t =(x5T-6); if t>0 then s=t/2; else s=-2*t; xBeta + s;
      x5S       =   4+int(rand('uniform')*2);
      t =(x5S-5); if t>0 then s=2*t; else s=-2*t/2; xBeta + s;
      x6A       = 330+20*rand('normal');
      t =(x6A-330); if t>0 then s=t/20; else s=-t/20; xBeta + s;
      x7A       = 110+20*rand('normal');
      t =(x7A-110); if t>0 then s=6*t/20; else s=-6*t/20; xBeta + s;
      x8E       =  40+int(rand('uniform')*10);
      x9T       = 100+5*rand('normal');
      x10T        =  35+int(rand('uniform')*10);
      t = (x10T-40); if t>0 then s=3*t/5; else s=-3*t/5; xBeta + s;
      x11T        =  20+int(rand('uniform')*10);
      t = (x11T-25); if t>0 then s=6*t/5; else s=-6*t/5; xBeta + s;
      x11E        = 425+15*rand('normal');
      t = (x11E-425); if t>0 then s=15*t/15; else s=-10*t/15; xBeta + s;
      x12E     =  60+10*rand('normal');
      x12H =  50+10*rand('normal');

      t = (425-x11E)*(x11T-25);
      s = t/25;
      xBeta = xBeta - s;

      y= round(100-xbeta)+4;
      if y > 100 then y=100;
      if y < 0   then y=0;
      g='L1';
      output;

      s=90/69;
      t=5-26*s;
      y=round(t+s*y)-5;
      if y > 100 then y=100;
      if y < 0   then y=0;
      g='L2';
      output;
  end;
run;

proc corr data=mylib.mytable;* plots=matrix(histogram) PLOTS(MAXPOINTS=100000);
run;

proc cas;
	table.tabledetails / level="sum" table="mytable";
	table.tabledetails / level="node" table="mytable";
	*table.tabledetails / level="partition" table="mytable";
run;

/*****************************************/
/*  Tip 1:  You can use utility actions  */
/*****************************************/

proc cas;
   columnInfo / table = 'mytable';
   summary / table='mytable';
   summary / table={name='mytable',groupBy='g'},
             inputs = 'y';
run;

/*************************************************************/
/* Tip 2:  Many analytic actions have standard proc wrappers */
/*************************************************************/

proc regselect data=mylib.mytable;
   model y = x1A x2A x3A x6A x7A
                 x4S x5S
                 x8E x11E x12E
                 x4T x5T x9T x10T x11T
                 x12H;
   selection method=forwardSwap;
run;

/**************************************************************/
/* Tip 3:  Use CAS history to find out what these wrappers do */
/**************************************************************/

proc cas;
   history{first=-4};
run;

/***************************************************/
/* Tip 4: You need to load the relevant action set */
/***************************************************/

proc cas;
   loadactionset / actionset='regression';
run;

/*****************************************************************/
/* Tip 5: Using the "data mining" syntax for main effects models */
/*****************************************************************/

proc cas;
   action regression.glm /
      table  = {name='mytable'},
      target = 'y',
      inputs = {
                 {name='x1A'}, {name='x2A'}, {name='x3A'}, {name='x6A'},
                 {name='x7A'}, {name='x4S'}, {name='x5S'}, {name='x8E'},
                 {name='x11E'}, {name='x12E'},{name='x4T'}, {name='x5T'},
                 {name='x9T'}, {name='x10T'}, {name='x11T'}, {name='x12H'}
               },
      selection = {method= 'FORWARDSWAP'} ;
run;

/**********************************************************/
/* Tip 6:  Use coercion to simplify the syntax you submit */
/*         Examine the status of your action              */
/**********************************************************/

   glm / table  = 'mytable',
         target = 'y',
         inputs = {
                    'x1A', 'x2A', 'x3A', 'x6A', 'x7A', 'x4S',
                    'x5S', 'x8E', 'x11E', 'x12E',
                    'x4T', 'x5T', 'x9T', 'x10T', 'x11T', 'x12H'
                  },
         selection = 'FORWARDSWAP';

   print _status;
   print _status.severity;
run;


/*********************************************************************/
/* Tip 7:  You can save your action results and status               */
/*         Use groupBy in the tables parameter to get BY processing  */
/*         Not all analytic actions support BY processing            */
/*********************************************************************/

   glm result = myResult status=myStatus /
         table  = {name='mytable',groupBy='g'},
         target = 'y',
         inputs = {
                    'x1A', 'x2A', 'x3A', 'x6A', 'x7A', 'x4S',
                    'x5S', 'x8E', 'x11E', 'x12E',
                    'x4T', 'x5T', 'x9T', 'x10T', 'x11T', 'x12H'
                  },
         selection = 'FORWARDSWAP';
run;


/*********************************************************/
/* Tip 8:  You can save your action results and status   */
/*         You can then print your saved results         */
/*         You can find out the contents of your results */
/*         You can print selected parts of your results  */
/*********************************************************/


   print myStatus; run;
   print myResult; run;
   describe myResult; run;
   print myResult['ByGroup2.SelectedModel.ParameterEstimates'];
run;

/************************************************************************/
/*  All the following tips are specific to a subset of analytic actions */
/************************************************************************/


/***********************************************************************/
/* Tip 9:  You can specify models with a more general syntax           */
/*         You can use the display parameter to select specific output */
/*         This is supported on an action-specific basis               */
/***********************************************************************/

   glm / table = {name='mytable',groupBy='g'},
         model = {
                   target  = 'y',
                   effects = {
                                'x1A', 'x2A', 'x3A', 'x6A', 'x7A', 'x4S',
                                'x5S', 'x8E', 'x11E', 'x12E',
                                'x4T', 'x5T', 'x9T', 'x10T', 'x11T', 'x12H'
                             }

                  },
            display   = {names={'SelectedEffects','Anova','FitStatistics'}},
            selection = 'FORWARDSWAP';
run;


/***************************************************************************/
/* Tip 10:  You can use Perl regular expressions to specify variables      */
/*          Strings enclosed in / / are interpreted as regular expressions */
/*          This is supported on an action-specific basis                  */
/***************************************************************************/


   glm / table  = {name='mytable',groupBy='g'},
         model={
                 target  = 'y',
                 effects = { '/A$/','/S$/','/E$/','/T$/','x12H' }
               },
         display   = {names={'SelectedEffects','Anova','FitStatistics'}},
         selection = 'FORWARDSWAP' ;
run;


/********************************************************************************/
/* Tip 11:  You can specify models correponding to PROC GLM type syntax         */
/*               model y = x1*x2 x3|x5|x5@2 x1*c1(c2);                          */
/*          You can use the !/ / syntax to get the complement of the expression */
/*          This is supported on an action-specific basis                       */
/********************************************************************************/


   glm / table  = {name='mytable',groupBy='g'},
         model={
                 target  = 'y',
                 effects = {
                               { vars = '!/y|g/' },
                               { vars = {'x11T','x11T'},interaction='CROSS' }
                           }
               },
         display   = {names={'SelectedEffects','Anova','FitStatistics'}},
         selection = 'FORWARDSWAP';
run;

/************************************************************************/
/* Tip 12:  You can use Perl regular expressions with GLM type syntax   */
/*             model y = x1*x2 x3|x5|x5@2 x1*c1(c2);                    */
/*          This is supported on an action-specific basis               */
/************************************************************************/


   glm / table  = {name='mytable',groupBy='g'},
         model={
                 target  = 'y',
                  effects = {
                                '!/y|g/',
                                 { vars = {'/T/','/T/'},interaction='BAR',maxinteract=2}
                            }
                },
         display   = {names={'SelectedEffects','Anova','FitStatistics'}},
         selection = 'FORWARDSWAP';
run;


/********************************************************************/
/* Tip 13:  You can use analogs of EFFECT statement syntax:         */
/*             splines, polynomials, collections, multimember       */
/*          You can use Perl expressions with the DISPLAY parameter */
/*          This is supported on an action-specific basis           */
/********************************************************************/


   glm / table  = {name='mytable',groupBy='g'},
         polynomial={
                       {  name   = 'myPoly',
                          vars   = {'!/y|g/'},
                          degree = 2
                       }
                    },
         model={
                 target  = 'y',
                 effects = 'myPoly'
               },
         display   = {names={'/SelectedModel/'}},
         selection = 'FORWARDSWAP';
run;

quit;

cas mysess clear;

/*This file was created by Robert Cohen.  All credit goes to him.*/
