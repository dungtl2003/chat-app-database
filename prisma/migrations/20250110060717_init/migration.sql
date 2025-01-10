/*
  Warnings:

  - You are about to drop the column `creator_id` on the `group` table. All the data in the column will be lost.
  - Added the required column `creator_id` to the `conversation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `conversation_id` to the `group` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "conversation"."conversation" ADD COLUMN     "creator_id" BIGINT NOT NULL;

-- AlterTable
ALTER TABLE "conversation"."group" DROP COLUMN "creator_id",
ADD COLUMN     "conversation_id" BIGINT NOT NULL;

-- AddForeignKey
ALTER TABLE "conversation"."conversation" ADD CONSTRAINT "conversation_creator_id_fkey" FOREIGN KEY ("creator_id") REFERENCES "user"."user"("id") ON DELETE CASCADE ON UPDATE CASCADE;
