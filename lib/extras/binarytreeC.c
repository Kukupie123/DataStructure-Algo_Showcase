#include <stdio.h>
#include <stdlib.h>
//Forward declaration
void setBinary(int, struct Node*);
void printBinary(struct Node);

//Our input array
int array[10] = {5, 7, 1, 15, 9, 2, 14, 8, 2, 3};

struct Node
{
    int value;
    struct Node* left;
    struct Node* right;
};

int main()
{
    struct Node startingNode;
    startingNode.left = NULL;
    startingNode.right = NULL;
    startingNode.value = -1;
    for (int i = 0; i < 10; i++)
    {
        //Check if our starting node is empty
        if (startingNode.value == -1)
        {
            //Starting node is empty so we put in the first value;
            startingNode.value = array[0];
        }
        else
        {
            setBinary(i, &startingNode);
        }
    }
    printBinary(startingNode);
}

void setBinary(int arrayPos, struct Node* parentNode)
{
    const int val = array[arrayPos];

    //Check if array[pos] > or < than given node's value
    if (val > parentNode->value)
    {
        //We need to go to the right side

        //Check if right node exists
        if (parentNode->right == NULL)
        {
            //No right child
            //Create a new node and set it as the new right child. also dont forget to set it's value
            struct Node* child = malloc(sizeof(struct Node));
            child->left = NULL;
            child->value = val;
            child->right = NULL;
            parentNode->right = child;
        }
        else
        {
            //Right child exists, set it as the new parentNode and do recursion
            setBinary(arrayPos, parentNode->right);
        }
    }
    else
    {
        //We need to go to the left side

        //Check if left node exists
        if (parentNode->left == NULL)
        {
            //No left child exists
            //Create a new node and set its' value
            //Once done we are going to set it as the left child

            struct Node* child = malloc(sizeof(struct Node));
            child->left = NULL;
            child->value = val;
            child->right = NULL;
            parentNode->left = child;
        }
        else
        {
            //Left child exists, set it as the new parentNode and do recursion
            setBinary(arrayPos, parentNode->left);
        }
    }
}

void printBinary(struct Node startingNode)
{
    printf("\n");

    printf("value : %d - ", startingNode.value);
    if (startingNode.left != NULL)
    {
        printf("LV : %d - ", startingNode.left->value);
        printBinary(*startingNode.left);
    }
    if (startingNode.right != NULL)
    {
        printf("RV : %d - ", startingNode.right->value);
        printBinary(*startingNode.right);
    }
}
