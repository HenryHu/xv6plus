4150 struct file {
4151   enum { FD_CLOSED, FD_NONE, FD_PIPE, FD_INODE } type;
4152   int ref; // reference count
4153   char readable;
4154   char writable;
4155   struct pipe *pipe;
4156   struct inode *ip;
4157   uint off;
4158 };
4159 
4160 
4161 
4162 
4163 
4164 
4165 
4166 
4167 
4168 
4169 
4170 
4171 
4172 
4173 
4174 
4175 
4176 
4177 
4178 
4179 
4180 
4181 
4182 
4183 
4184 
4185 
4186 
4187 
4188 
4189 
4190 
4191 
4192 
4193 
4194 
4195 
4196 
4197 
4198 
4199 
