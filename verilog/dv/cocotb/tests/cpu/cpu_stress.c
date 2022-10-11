#include <defs.h>

int A[]={1, 40, 2, 5, 22, 11, 90, 200, 10, 20, 25};

// int factorial(int n) {
//    int fac=1;
//    for(int i=1; i<=n;++i){
//       fac = fac * i; 
//    }
//    return fac;
// }

int fibbonacci(int n) {
   if(n == 0){
      return 0;
   } else if(n == 1) {
      return 1;
   } else {
      return (fibbonacci(n-1) + fibbonacci(n-2));
   }
}

void recursiveInsertionSort(int arr[], int n){
   if (n <= 1)
      return;
   recursiveInsertionSort( arr, n-1 );
   int nth = arr[n-1];
   int j = n-2;
   while (j >= 0 && arr[j] > nth){
      arr[j+1] = arr[j];
      j--;
   }
   arr[j+1] = nth;
}


void quick_sort(int number[],int first,int last){
   int i, j, pivot, temp;

   if(first<last){
      pivot=first;
      i=first;
      j=last;

      while(i<j){
         while(number[i]<=number[pivot]&&i<last)
            i++;
         while(number[j]>number[pivot])
            j--;
         if(i<j){
            temp=number[i];
            number[i]=number[j];
            number[j]=temp;
         }
      }

      temp=number[pivot];
      number[pivot]=number[j];
      number[j]=temp;
      quick_sort(number,first,j-1);
      quick_sort(number,j+1,last);

   }
}
int f4(int a, int b, int c, int d){
   return a + b + c + d;
}

int f5(int a, int b, int c, int d, int e){
   return e + f4(a, b, c, d);
}

int f6(int a, int b, int c, int d, int e, int f){
   return f + f5(a, b, c, d, e);
}

int f7(int a, int b, int c, int d, int e, int f, int g){
   return g + f6(a, b, c, d, e, f);
}
int f8(int a, int b, int c, int d, int e, int f, int g, int h){
   return h + f7(a, b, c, d, e, f, g);
}
/*
Stress the cpu with heavy processing
   
*/
void main()
{
    int n;
    int B[10];
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;
    // start test
    //  reg_mprj_datal = 0xAAAA0000;

    //  n =factorial(12);
    //  if(n != 479001600)
    //      reg_mprj_datal = 0xFFFF0000; //fail

    //  reg_mprj_datal = 0x11110000; //phase 1 pass

    n = fibbonacci(10);
    if(n != 55)
        reg_debug_1 = 0x1E; // fail pahse 1
    else
        reg_debug_1 = 0x1B; // pass pahse 1

    int sumA = 0;
    for(int i=0; i<10; i++){
        B[i] = A[i];
        sumA += A[i];
    }

    if(sumA != 401)
        reg_debug_1 = 0x2E; // fail pahse 2
    else 
        reg_debug_1 = 0x2B; // pass pahse 2

    recursiveInsertionSort(B, 10);

    int sumB = 0;
    for(int i=0; i<10; i++){
        sumB += B[i];
    }

    if(sumA != sumB)
        reg_debug_1 = 0x3E;// fail pahse 3
    else 
        reg_debug_1 = 0x3B; // pass pahse 3

    for(int i=0; i<10; i++){
        B[i] = A[i];
        sumA += A[i];
    }
    quick_sort(B, 0, 9);

    for(int i=0; i<10; i++){
        sumB += B[i];
    }

    if(sumA != sumB)
        reg_debug_1 = 0x4E;// fail pahse 4
    else 
        reg_debug_1 = 0x4B; // pass pahse 4

    int sum = f8(10, 20, 30, 40, 50, 60, 70, 80);

    if(sum != (10+20+30+40+50+60+70+80))
        reg_debug_1 = 0x5E; // fail pahse 5
    else 
        reg_debug_1 = 0x5B; // pass pahse 5

    // test finish 
    reg_debug_2 = 0xFF;
}