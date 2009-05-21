0850 // Format of an ELF executable file
0851 
0852 #define ELF_MAGIC 0x464C457FU  // "\x7FELF" in little endian
0853 
0854 // File header
0855 struct elfhdr {
0856   uint magic;  // must equal ELF_MAGIC
0857   uchar elf[12];
0858   ushort type;
0859   ushort machine;
0860   uint version;
0861   uint entry;
0862   uint phoff;
0863   uint shoff;
0864   uint flags;
0865   ushort ehsize;
0866   ushort phentsize;
0867   ushort phnum;
0868   ushort shentsize;
0869   ushort shnum;
0870   ushort shstrndx;
0871 };
0872 
0873 // Program section header
0874 struct proghdr {
0875   uint type;
0876   uint offset;
0877   uint va;
0878   uint pa;
0879   uint filesz;
0880   uint memsz;
0881   uint flags;
0882   uint align;
0883 };
0884 
0885 // Values for Proghdr type
0886 #define ELF_PROG_LOAD           1
0887 
0888 // Flag bits for Proghdr flags
0889 #define ELF_PROG_FLAG_EXEC      1
0890 #define ELF_PROG_FLAG_WRITE     2
0891 #define ELF_PROG_FLAG_READ      4
0892 
0893 
0894 
0895 
0896 
0897 
0898 
0899 
0900 // Blank page.
0901 
0902 
0903 
0904 
0905 
0906 
0907 
0908 
0909 
0910 
0911 
0912 
0913 
0914 
0915 
0916 
0917 
0918 
0919 
0920 
0921 
0922 
0923 
0924 
0925 
0926 
0927 
0928 
0929 
0930 
0931 
0932 
0933 
0934 
0935 
0936 
0937 
0938 
0939 
0940 
0941 
0942 
0943 
0944 
0945 
0946 
0947 
0948 
0949 
