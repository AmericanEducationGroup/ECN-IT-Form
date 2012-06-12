int main()

{
    int i, j, directory = 103, position;
	// for each school
	for(i = 0; i < 14; i++)
	{
		printf("\n-- American Education Group/Schools/Fusion Division/\n");
		printf("--   Staff\n");
		// for each Staff read position
		for(position = 34 + 13 * i; position < 47 + 13 * i; position++)
		{
			printf("INSERT INTO Read_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		}
		printf("\n");
		// for each Staff edit position
		for(position = 34 + 13 * i; position < 47 + 13 * i; position++)
		{
			printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		}
		directory++;

		
		printf("\n--   Public\n");
		// for each Public edit position
		for(position = 34 + 13 * i; position < 47 + 13 * i; position++)
		{
			printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		}
		directory++;

		
		printf("\n--   Administrators\n");
		// Admin read
		position = 34 + 13 * i;
		printf("INSERT INTO Read_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		position += 2;
		printf("INSERT INTO Read_Permissions(position, directory) VALUES (%d, %d);\n", position++, directory);
		printf("INSERT INTO Read_Permissions(position, directory) VALUES (%d, %d);\n", position++, directory);
		printf("INSERT INTO Read_Permissions(position, directory) VALUES (%d, %d);\n", position++, directory);
		printf("INSERT INTO Read_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		position += 2;
		printf("INSERT INTO Read_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		position += 2;
		printf("INSERT INTO Read_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		
		// Admin edit
		position = 34 + 13 * i;
		printf("\nINSERT INTO Edit_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		position += 2;
		printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, %d);\n", position++, directory);
		printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, %d);\n", position++, directory);
		printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, %d);\n", position++, directory);
		printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		position += 2;
		printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		position += 2;
		printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		directory++;

		
		printf("\n--   Head of School\n");
		// HOS read
		position = 41 + 13 * i;
		printf("INSERT INTO Read_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		// HOS edit
		position = 41 + 13 * i;
		printf("\nINSERT INTO Edit_Permissions(position, directory) VALUES (%d, %d);\n", position, directory);
		directory++;
	}
	return 0;
}
