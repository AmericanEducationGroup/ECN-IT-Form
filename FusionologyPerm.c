int main()
{
	int i, j, position;

	for(i = 1; i < 34; i++)
		printf("INSERT INTO Read_Permissions(position, directory) VALUES (%d, 159);\n", i);

	// for each school
	for(i = 0; i < 15; i++)
	{
		position = 34 + 13 * i;
		printf("INSERT INTO Read_Permissions(position, directory) VALUES (%d, 159);\n", position);
		position += 2;
		for(j = 0; j < 9; j++)
			printf("INSERT INTO Read_Permissions(position, directory) VALUES (%d, 159);\n", position + j);
	}
	return 0;
}
