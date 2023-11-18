// Program.cs
using System.Runtime.InteropServices;

class Program {

    static void Main() {
        int result = NativeMethods.Add(2, 3);
        Console.WriteLine(result);  // Outputs: 5
    }
}

static class NativeMethods {
    #if WINDOWS
    private const string LibraryName = "clib.dll";
    #elif LINUX || OSX
    private const string LibraryName = "clib.so";
    #else
    #error Unknown platform
    #endif

    [DllImport(LibraryName, CallingConvention = CallingConvention.Cdecl, EntryPoint = "add")]
    public static extern int Add(int a, int b);
}