1、读取X_test,X_train.y_test,y_train,Subject_test,Subject_train,features and activity_lables 文本文件

2、列合并y_train,subject_train-->train_y_subject

3、列合并y_test,subject_test-->test_y_subject

4、行合并train_y_subject,test_y_subject--->y_subject

5、行合并x_train,x_test-->x

6、用features中的标签更改x的列名称

7、删除x中名称不含有mean()或std()的列-->Eliminate_mean_std

8、列合并x,y_subject-->y_subject_Eliminate_mean_std

9、对每activity每subject求各列的均值-->mean

10、将mean中activity值更改为activity_lables.txt中的对应值,生成最终数据集dd

11、用write.table()写出数据集dd

