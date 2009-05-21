
bootblock.o:     file format elf32-i386-freebsd

Disassembly of section .text:

00007c00 <start>:
    7c00:	fa                   	cli    
    7c01:	fc                   	cld    
    7c02:	31 c0                	xor    %eax,%eax
    7c04:	8e d8                	mov    %eax,%ds
    7c06:	8e c0                	mov    %eax,%es
    7c08:	8e d0                	mov    %eax,%ss

00007c0a <seta20.1>:
    7c0a:	e4 64                	in     $0x64,%al
    7c0c:	a8 02                	test   $0x2,%al
    7c0e:	75 fa                	jne    7c0a <seta20.1>
    7c10:	b0 d1                	mov    $0xd1,%al
    7c12:	e6 64                	out    %al,$0x64

00007c14 <seta20.2>:
    7c14:	e4 64                	in     $0x64,%al
    7c16:	a8 02                	test   $0x2,%al
    7c18:	75 fa                	jne    7c14 <seta20.2>
    7c1a:	b0 df                	mov    $0xdf,%al
    7c1c:	e6 60                	out    %al,$0x60
    7c1e:	0f 01 16             	lgdtl  (%esi)
    7c21:	64                   	fs
    7c22:	7c 0f                	jl     7c33 <protcseg+0x1>
    7c24:	20 c0                	and    %al,%al
    7c26:	66 83 c8 01          	or     $0x1,%ax
    7c2a:	0f 22 c0             	mov    %eax,%cr0
    7c2d:	ea 32 7c 08 00 66 b8 	ljmp   $0xb866,$0x87c32

00007c32 <protcseg>:
    7c32:	66 b8 10 00          	mov    $0x10,%ax
    7c36:	8e d8                	mov    %eax,%ds
    7c38:	8e c0                	mov    %eax,%es
    7c3a:	8e e0                	mov    %eax,%fs
    7c3c:	8e e8                	mov    %eax,%gs
    7c3e:	8e d0                	mov    %eax,%ss
    7c40:	bc 00 7c 00 00       	mov    $0x7c00,%esp
    7c45:	e8 06 01 00 00       	call   7d50 <bootmain>

00007c4a <spin>:
    7c4a:	eb fe                	jmp    7c4a <spin>

00007c4c <gdt>:
	...
    7c54:	ff                   	(bad)  
    7c55:	ff 00                	incl   (%eax)
    7c57:	00 00                	add    %al,(%eax)
    7c59:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7c60:	00 92 cf 00 17 00    	add    %dl,0x1700cf(%edx)

00007c64 <gdtdesc>:
    7c64:	17                   	pop    %ss
    7c65:	00 4c 7c 00          	add    %cl,0x0(%esp,%edi,2)
    7c69:	00 90 90 90 90 90    	add    %dl,0x90909090(%eax)
    7c6f:	90                   	nop    

00007c70 <waitdisk>:
    7c70:	55                   	push   %ebp
    7c71:	89 e5                	mov    %esp,%ebp
    7c73:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c78:	ec                   	in     (%dx),%al
    7c79:	25 c0 00 00 00       	and    $0xc0,%eax
    7c7e:	83 f8 40             	cmp    $0x40,%eax
    7c81:	75 f0                	jne    7c73 <waitdisk+0x3>
    7c83:	5d                   	pop    %ebp
    7c84:	c3                   	ret    
    7c85:	8d 74 26 00          	lea    0x0(%esi),%esi
    7c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00007c90 <readsect>:
    7c90:	55                   	push   %ebp
    7c91:	89 e5                	mov    %esp,%ebp
    7c93:	57                   	push   %edi
    7c94:	53                   	push   %ebx
    7c95:	8b 7d 08             	mov    0x8(%ebp),%edi
    7c98:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7c9b:	e8 d0 ff ff ff       	call   7c70 <waitdisk>
    7ca0:	b8 01 00 00 00       	mov    $0x1,%eax
    7ca5:	ba f2 01 00 00       	mov    $0x1f2,%edx
    7caa:	ee                   	out    %al,(%dx)
    7cab:	b2 f3                	mov    $0xf3,%dl
    7cad:	89 d8                	mov    %ebx,%eax
    7caf:	ee                   	out    %al,(%dx)
    7cb0:	89 d8                	mov    %ebx,%eax
    7cb2:	c1 e8 08             	shr    $0x8,%eax
    7cb5:	b2 f4                	mov    $0xf4,%dl
    7cb7:	ee                   	out    %al,(%dx)
    7cb8:	89 d8                	mov    %ebx,%eax
    7cba:	c1 e8 10             	shr    $0x10,%eax
    7cbd:	b2 f5                	mov    $0xf5,%dl
    7cbf:	ee                   	out    %al,(%dx)
    7cc0:	89 d8                	mov    %ebx,%eax
    7cc2:	c1 e8 18             	shr    $0x18,%eax
    7cc5:	83 c8 e0             	or     $0xffffffe0,%eax
    7cc8:	b2 f6                	mov    $0xf6,%dl
    7cca:	ee                   	out    %al,(%dx)
    7ccb:	b8 20 00 00 00       	mov    $0x20,%eax
    7cd0:	b2 f7                	mov    $0xf7,%dl
    7cd2:	ee                   	out    %al,(%dx)
    7cd3:	e8 98 ff ff ff       	call   7c70 <waitdisk>
    7cd8:	ba f0 01 00 00       	mov    $0x1f0,%edx
    7cdd:	b9 80 00 00 00       	mov    $0x80,%ecx
    7ce2:	fc                   	cld    
    7ce3:	f2 6d                	repnz insl (%dx),%es:(%edi)
    7ce5:	5b                   	pop    %ebx
    7ce6:	5f                   	pop    %edi
    7ce7:	5d                   	pop    %ebp
    7ce8:	c3                   	ret    
    7ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00007cf0 <readseg>:
    7cf0:	55                   	push   %ebp
    7cf1:	89 e5                	mov    %esp,%ebp
    7cf3:	57                   	push   %edi
    7cf4:	56                   	push   %esi
    7cf5:	53                   	push   %ebx
    7cf6:	83 ec 08             	sub    $0x8,%esp
    7cf9:	8b 55 08             	mov    0x8(%ebp),%edx
    7cfc:	89 d0                	mov    %edx,%eax
    7cfe:	25 ff ff ff 00       	and    $0xffffff,%eax
    7d03:	8b 7d 0c             	mov    0xc(%ebp),%edi
    7d06:	01 c7                	add    %eax,%edi
    7d08:	89 d6                	mov    %edx,%esi
    7d0a:	81 e6 00 fe ff 00    	and    $0xfffe00,%esi
    7d10:	39 f7                	cmp    %esi,%edi
    7d12:	76 25                	jbe    7d39 <readseg+0x49>
    7d14:	8b 45 10             	mov    0x10(%ebp),%eax
    7d17:	c1 e8 09             	shr    $0x9,%eax
    7d1a:	8d 58 01             	lea    0x1(%eax),%ebx
    7d1d:	8d 76 00             	lea    0x0(%esi),%esi
    7d20:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    7d24:	89 34 24             	mov    %esi,(%esp)
    7d27:	e8 64 ff ff ff       	call   7c90 <readsect>
    7d2c:	81 c6 00 02 00 00    	add    $0x200,%esi
    7d32:	83 c3 01             	add    $0x1,%ebx
    7d35:	39 f7                	cmp    %esi,%edi
    7d37:	77 e7                	ja     7d20 <readseg+0x30>
    7d39:	83 c4 08             	add    $0x8,%esp
    7d3c:	5b                   	pop    %ebx
    7d3d:	5e                   	pop    %esi
    7d3e:	5f                   	pop    %edi
    7d3f:	5d                   	pop    %ebp
    7d40:	c3                   	ret    
    7d41:	eb 0d                	jmp    7d50 <bootmain>
    7d43:	90                   	nop    
    7d44:	90                   	nop    
    7d45:	90                   	nop    
    7d46:	90                   	nop    
    7d47:	90                   	nop    
    7d48:	90                   	nop    
    7d49:	90                   	nop    
    7d4a:	90                   	nop    
    7d4b:	90                   	nop    
    7d4c:	90                   	nop    
    7d4d:	90                   	nop    
    7d4e:	90                   	nop    
    7d4f:	90                   	nop    

00007d50 <bootmain>:
    7d50:	55                   	push   %ebp
    7d51:	89 e5                	mov    %esp,%ebp
    7d53:	56                   	push   %esi
    7d54:	53                   	push   %ebx
    7d55:	83 ec 10             	sub    $0x10,%esp
    7d58:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    7d5f:	00 
    7d60:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    7d67:	00 
    7d68:	c7 04 24 00 00 01 00 	movl   $0x10000,(%esp)
    7d6f:	e8 7c ff ff ff       	call   7cf0 <readseg>
    7d74:	81 3d 00 00 01 00 7f 	cmpl   $0x464c457f,0x10000
    7d7b:	45 4c 46 
    7d7e:	75 49                	jne    7dc9 <bootmain+0x79>
    7d80:	8b 1d 1c 00 01 00    	mov    0x1001c,%ebx
    7d86:	81 c3 00 00 01 00    	add    $0x10000,%ebx
    7d8c:	0f b7 05 2c 00 01 00 	movzwl 0x1002c,%eax
    7d93:	c1 e0 05             	shl    $0x5,%eax
    7d96:	8d 34 18             	lea    (%eax,%ebx,1),%esi
    7d99:	39 f3                	cmp    %esi,%ebx
    7d9b:	73 20                	jae    7dbd <bootmain+0x6d>
    7d9d:	8b 43 04             	mov    0x4(%ebx),%eax
    7da0:	89 44 24 08          	mov    %eax,0x8(%esp)
    7da4:	8b 43 14             	mov    0x14(%ebx),%eax
    7da7:	89 44 24 04          	mov    %eax,0x4(%esp)
    7dab:	8b 43 08             	mov    0x8(%ebx),%eax
    7dae:	89 04 24             	mov    %eax,(%esp)
    7db1:	e8 3a ff ff ff       	call   7cf0 <readseg>
    7db6:	83 c3 20             	add    $0x20,%ebx
    7db9:	39 de                	cmp    %ebx,%esi
    7dbb:	77 e0                	ja     7d9d <bootmain+0x4d>
    7dbd:	a1 18 00 01 00       	mov    0x10018,%eax
    7dc2:	25 ff ff ff 00       	and    $0xffffff,%eax
    7dc7:	ff d0                	call   *%eax
    7dc9:	b8 00 8a ff ff       	mov    $0xffff8a00,%eax
    7dce:	ba 00 8a ff ff       	mov    $0xffff8a00,%edx
    7dd3:	66 ef                	out    %ax,(%dx)
    7dd5:	b8 00 8e ff ff       	mov    $0xffff8e00,%eax
    7dda:	66 ef                	out    %ax,(%dx)
    7ddc:	8d 74 26 00          	lea    0x0(%esi),%esi
    7de0:	eb fe                	jmp    7de0 <bootmain+0x90>
