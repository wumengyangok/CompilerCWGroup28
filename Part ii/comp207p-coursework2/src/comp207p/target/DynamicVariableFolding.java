package comp207p.target;

public class DynamicVariableFolding {
    public int methodOne() {
        int a = 42;
        int b = (a + 764) * 3;
        a = b - 67;
        return b + 1234 - a;
    }

    public boolean methodTwo() {
        int x = 12345;
        int y = 54321;
        System.out.println(x < y);
        y = 0;
        return x > y;
    }

    public int methodThree() {
        int i = 0;
        int j = i + 3;
        i = j + 4;
        j = i + 5;
        return i * j;
    }
    
    public int methodFour(){
        int a = 534245;
        int b = a - 1234;
        System.out.println((120298345 - a) * 38.435792873);
        for(int i = 0; i < 10; i++){
            System.out.println((b - a) * i);
        }
        a = 4;
        b = a + 2;
        return a * b;
    }
    
    public int loop() {
        int a = 1;
        int n = 10;
        n = 10;
        while (a < n) {
            a++;
        }
        return a;
    }

    public int loop1() {
        int a = 1000;
        for (int i = 0; i < 100; i++) {
            a = 10;
            int b = a + 10;
            a = 200;
            b = a + b;
            if (a > 100) {
                a = 10;
            }
        }
        if (a == 10) {
            a = 5;
        } else if (a == 2) {
            a = 3;
        } else {
            a = 6;
        }
        return a;
    }

    public static void qsort(int a[], int l, int r){
        if (l==r)
            return;
        int i=l, j=r;
        int p=i;
        while (i<j){
            if (a[i]<a[j]) {
                int temp=a[i];
                a[i]=a[p];
                a[p]=temp;
                i++;p++;
            }else{
                i++;
            }
        }
        int temp=a[j];
        a[j]=a[p];
        a[p]=temp;
        if(p>l)
            qsort(a,l,p-1);
        if(p<r)
            qsort(a,p+1,r);
    }
}