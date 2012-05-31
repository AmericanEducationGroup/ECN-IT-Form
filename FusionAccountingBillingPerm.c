int main()
{
	int i, j, position;
	
	// for each school
	for(i = 0; i < 15; i++)
	{
		position = 34 + 13 * i;
		printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, 169);\n", position);
		position += 4;
		printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, 169);\n", position);
		position += 3;
		printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, 169);\n", position++);
		printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, 169);\n", position++);
		printf("INSERT INTO Edit_Permissions(position, directory) VALUES (%d, 169);\n", position);
	}
	return 0;
}
