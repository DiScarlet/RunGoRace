using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class Program
    {
        public static void Main()
        {
            ListNode listNode = new ListNode(0);
            PrintListNode(RotateRight(listNode, 4));
        }

        public static void PrintListNode(ListNode head)
        {
            ListNode current = head;
            while (current != null)
            {
                Console.Write(current.val + " ");
                current = current.next;
            }
            Console.WriteLine();
        }

        public class ListNode
        {
            public int val;
            public ListNode next;
            public ListNode(int val = 0, ListNode next = null)
            {
                this.val = val;
                this.next = next;
            }
        }

        public static ListNode RotateRight(ListNode head, int k)
        {
            ListNode end = head, start = head;
            int endInd = 0, startInd = 0;

            while (end.next != null)
            {
                endInd++;
                end = end.next;
            }

            if (endInd + 1 < k)
                k = k - ((endInd + 1) * (k / (endInd + 1)));

            while (startInd != endInd - k)
            {
                start = start.next;
                startInd++;
            }

            ListNode newHead = start.next;
            start.next = null;
            end.next = head;

            return newHead;
        }
    }
}
